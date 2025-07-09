import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as gets;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:revalesuva/utils/enums.dart';
import 'package:revalesuva/utils/router.dart';
import 'package:revalesuva/view_models/user_view_model.dart';

import 'api_status.dart';

// Define the QueuedRequest class
class _QueuedRequest {
  final Future<dynamic> Function() requestFunction;
  final Completer<dynamic> completer;

  _QueuedRequest(this.requestFunction, this.completer);
}

class APIServices {
  static final APIServices instance = APIServices._internal();

  // Request queue implementation
  final _requestQueue = <_QueuedRequest>[];
  final _maxConcurrentRequests = 2; // Allow 2 concurrent requests max
  int _activeRequests = 0;

  factory APIServices() {
    return instance;
  }

  APIServices._internal() {
    _configDio();
  }

  final dio = Dio();

  void _configDio() {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 60), // Reduced from 300
      receiveTimeout: const Duration(seconds: 60), // Reduced from 300
      responseType: ResponseType.json,
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: false,
          request: false,
          requestBody: false,
          responseBody: false,
          responseHeader: false,
          error: false,
          compact: false,
          logPrint: (object) {
            debugPrint(object.toString());
          },
          maxWidth: 90,
        ),
      );
    }

    // Add request interceptor for connection error prevention
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // Implement retry logic for specific errors
        if (_shouldRetry(e) && e.requestOptions.extra['retryCount'] == null) {
          // Create a new request options object
          final options = Options(
            method: e.requestOptions.method,
            headers: e.requestOptions.headers,
          );

          // Add retry count
          e.requestOptions.extra['retryCount'] = 1;

          debugPrint("⚠️ Retrying request due to error: ${e.message}");

          // Delay before retry to give server some breathing room
          await Future.delayed(const Duration(seconds: 2));

          try {
            final response = await dio.request(
              e.requestOptions.path,
              options: options,
              data: e.requestOptions.data,
              queryParameters: e.requestOptions.queryParameters,
            );
            return handler.resolve(response);
          } catch (retryError) {
            return handler.next(e);
          }
        }
        return handler.next(e);
      },
    ));
  }

  // Helper to determine if a request should be retried
  bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        (e.type == DioExceptionType.connectionError && e.error is SocketException) ||
        e.response?.statusCode == 500 ||
        e.response?.statusCode == 503;
  }

  // Queue system for limiting concurrent requests
  Future<dynamic> _enqueueRequest(Future<dynamic> Function() requestFunction) async {
    final completer = Completer<dynamic>();

    _requestQueue.add(_QueuedRequest(requestFunction, completer));
    _processQueue();

    return completer.future;
  }

  void _processQueue() {
    if (_requestQueue.isEmpty || _activeRequests >= _maxConcurrentRequests) {
      return;
    }

    final request = _requestQueue.removeAt(0);
    _activeRequests++;

    request.requestFunction().then((result) {
      request.completer.complete(result);
    }).catchError((error) {
      request.completer.completeError(error);
    }).whenComplete(() {
      _activeRequests--;
      _processQueue(); // Process next request
    });
  }

  // Get auth token consistently
  String _getAuthToken() {
    return gets.Get.find<UserViewModel>().authToken.value;
  }

  // Handle unauthorized consistently
  void _handleUnauthorized() {
    gets.Get.find<UserViewModel>().clearUser();
    gets.Get.offAllNamed(RoutesName.login);
  }

  Future<dynamic> getAPICall(
      {required String url, required Map<String, dynamic> param, bool? isRaw}) async {
    return _enqueueRequest(() async {
      try {
        var response = await dio.get(
          url,
          queryParameters: param,
          options: Options(
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.acceptHeader: "application/json",
            },
          ),
        );
        return Success(code: response.statusCode, response: response);
      } on DioException catch (e) {
        String errorMessage = _handleDioError(e);
        if (e.response?.statusCode == 401) {
          _handleUnauthorized();
        }
        return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
      } catch (e) {
        return Failure(code: 0, errorResponse: e.toString());
      }
    });
  }

  Future<dynamic> postAPICall(
      {required Map<String, dynamic> param, required String url, required ParamType paramType}) async {
    return _enqueueRequest(() async {
      try {
        var response = await dio.post(
          url,
          options: Options(
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader:
                  paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded",
              HttpHeaders.acceptHeader:
                  paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded"
            },
          ),
          data: paramType == ParamType.raw ? json.encode(param) : param,
        );
        return Success(code: response.statusCode, response: response);
      } on DioException catch (e) {
        String errorMessage = _handleDioError(e);
        if (e.response?.statusCode == 401) {
          _handleUnauthorized();
        }
        return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
      } catch (e) {
        return Failure(code: 0, errorResponse: e.toString());
      }
    });
  }

  Future<dynamic> getAPICallAuth({
    required String url,
    required Map<String, dynamic> param,
    bool? isRaw,
    bool isData = false,
  }) async {
    return _enqueueRequest(() async {
      var authenticationToken = _getAuthToken();
      if (authenticationToken.isNotEmpty) {
        try {
          var response = await dio.get(
            url,
            queryParameters: isData ? null : param,
            data: isData ? param : null,
            options: Options(
              responseType: ResponseType.json,
              headers: {
                HttpHeaders.acceptHeader: "application/json",
                HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
              },
            ),
          );
          return Success(code: response.statusCode, response: response);
        } on DioException catch (e) {
          String errorMessage = _handleDioError(e);
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
        } catch (e) {
          return Failure(code: 0, errorResponse: e.toString());
        }
      } else {
        _handleUnauthorized();
        return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
      }
    });
  }

  Future<dynamic> postAPICallAuth(
      {required Map<String, dynamic> param, required String url, required ParamType paramType}) async {
    return _enqueueRequest(() async {
      var authenticationToken = _getAuthToken();
      if (authenticationToken.isNotEmpty) {
        try {
          var response = await dio.post(
            url,
            options: Options(
              responseType: ResponseType.json,
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
                HttpHeaders.contentTypeHeader: paramType == ParamType.raw
                    ? "application/json"
                    : "application/x-www-form-urlencoded",
                HttpHeaders.acceptHeader:
                    paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded"
              },
            ),
            data: paramType == ParamType.raw ? json.encode(param) : param,
          );
          return Success(code: response.statusCode, response: response);
        } on DioException catch (e) {
          String errorMessage = _handleDioError(e);
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
        } catch (e) {
          return Failure(code: 0, errorResponse: e.toString());
        }
      } else {
        _handleUnauthorized();
        return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
      }
    });
  }

  Future<dynamic> deleteAPICallAuth(
      {required Map<String, dynamic> param, required String url, required ParamType paramType}) async {
    return _enqueueRequest(() async {
      var authenticationToken = _getAuthToken();
      if (authenticationToken.isNotEmpty) {
        try {
          var response = await dio.delete(
            url,
            options: Options(
              responseType: ResponseType.json,
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
                HttpHeaders.contentTypeHeader: paramType == ParamType.raw
                    ? "application/json"
                    : "application/x-www-form-urlencoded",
                HttpHeaders.acceptHeader:
                    paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded"
              },
            ),
            data: paramType == ParamType.raw ? json.encode(param) : param,
          );
          return Success(code: response.statusCode, response: response);
        } on DioException catch (e) {
          String errorMessage = _handleDioError(e);
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
        } catch (e) {
          return Failure(code: 0, errorResponse: e.toString());
        }
      } else {
        _handleUnauthorized();
        return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
      }
    });
  }

  Future<dynamic> postAPICallAuthFileUpload({
    required Map<String, dynamic> param,
    required String url,
  }) async {
    return _enqueueRequest(() async {
      var authenticationToken = _getAuthToken();
      if (authenticationToken.isNotEmpty) {
        try {
          FormData formData = FormData();
          for (var entry in param.entries) {
            var key = entry.key;
            var value = entry.value;
            if ((key == "back_pic" ||
                    key == "side_pic" ||
                    key == "front_pic" ||
                    key == "profile_image") &&
                value != null) {
              formData.files.add(
                MapEntry(
                  key,
                  await MultipartFile.fromFile(
                    File(value).path,
                    filename: File(value).path.split('/').last,
                  ),
                ),
              );
            } else if (key == "blood_test_report" && value != null) {
              if (value is List<String>) {
                for (var element in value) {
                  formData.files.add(
                    MapEntry(
                      "$key[]",
                      await MultipartFile.fromFile(
                        File(element).path,
                        filename: File(element).path.split('/').last,
                      ),
                    ),
                  );
                }
              }
            } else {
              if (value != null) {
                formData.fields.add(MapEntry(key, value.toString()));
              }
            }
          }
          formData.fields.add(const MapEntry("_method", "PUT"));

          // Set a custom timeout for file uploads
          var response = await dio.post(
            url,
            options: Options(
              responseType: ResponseType.json,
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
              },
              // Longer timeout specifically for file uploads
              sendTimeout: const Duration(minutes: 5),
              receiveTimeout: const Duration(minutes: 5),
            ),
            data: formData,
            onSendProgress: (sent, total) {
              // Could be used to update a progress indicator
              final progress = (sent / total) * 100;
              debugPrint('Upload progress: ${progress.toStringAsFixed(2)}%');
            },
          );
          return Success(code: response.statusCode, response: response);
        } on DioException catch (e) {
          String errorMessage = _handleDioError(e);
          if (e.response?.statusCode == 401) {
            _handleUnauthorized();
          }
          return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
        } catch (e) {
          return Failure(code: 0, errorResponse: e.toString());
        }
      } else {
        _handleUnauthorized();
        return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
      }
    });
  }

  String _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return "Connection timeout. The server is taking too long to respond, please try again later.";
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return "Receive timeout. The server took too long to send data, please try again later.";
    }
    if (e.type == DioExceptionType.sendTimeout) {
      return "Send timeout. It took too long to send data to the server, please check your connection.";
    }
    if (e.type == DioExceptionType.connectionError && e.error is SocketException) {
      return "No network found. Please check your internet connection.";
    }
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return e.response?.data["message"];
        case 401:
          gets.Get.find<UserViewModel>().clearUser();
          return "Unauthorized. Please check your credentials.";
        case 403:
          return "Forbidden. You don't have permission to access this resource.";
        case 404:
          var mes = jsonDecode(e.response.toString())["message"];
          return mes;
        case 500:
          return "internal server error something went wrong in server side";
        default:
          return e.response?.data["message"] ?? "Something went wrong. Please try again.";
      }
    } else {
      return e.message ?? "";
    }
  }
}
