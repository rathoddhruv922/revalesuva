// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart' as gets;
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:revalesuva/utils/enums.dart';
// import 'package:revalesuva/utils/router.dart';
// import 'package:revalesuva/view_models/user_view_model.dart';
//
// import 'api_status.dart';
//
// class APIServices {
//   static final APIServices instance = APIServices._internal();
//
//   factory APIServices() {
//     return instance;
//   }
//
//   APIServices._internal();
//
//   final dio = Dio(
//     BaseOptions(
//       connectTimeout: const Duration(seconds: 300),
//       receiveTimeout: const Duration(seconds: 300),
//       responseType: ResponseType.json,
//     ),
//   )..interceptors.addAll(
//       kDebugMode
//           ? [
//               PrettyDioLogger(
//                 requestHeader: false,
//                 request: true,
//                 requestBody: true,
//                 responseBody: true,
//                 responseHeader: false,
//                 error: true,
//                 compact: true,
//                 logPrint: (object) {
//                   debugPrint(object.toString());
//                 },
//                 maxWidth: 90,
//               ),
//             ]
//           : [],
//     );
//
//   getAPICall({required String url, required Map<String, dynamic> param, bool? isRaw}) async {
//     try {
//       var response = await dio.get(
//         url,
//         queryParameters: param,
//         options: Options(
//           responseType: ResponseType.json,
//           headers: {
//             HttpHeaders.acceptHeader: "application/json",
//           },
//         ),
//       );
//       return Success(code: response.statusCode, response: response);
//     } on DioException catch (e) {
//       String errorMessage = _handleDioError(e);
//       if (e.response?.statusCode == 401) {
//         gets.Get.offAllNamed(RoutesName.login);
//       }
//       return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
//     } catch (e) {
//       return Failure(code: 0, errorResponse: e.toString());
//     }
//   }
//
//   postAPICall(
//       {required Map<String, dynamic> param, required String url, required ParamType paramType}) async {
//     try {
//       var response = await dio.post(
//         url,
//         options: Options(
//           responseType: ResponseType.json,
//           headers: {
//             HttpHeaders.contentTypeHeader:
//                 paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded",
//             HttpHeaders.acceptHeader:
//                 paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded"
//           },
//         ),
//         data: paramType == ParamType.raw ? json.encode(param) : param,
//       );
//       return Success(code: response.statusCode, response: response);
//     } on DioException catch (e) {
//       String errorMessage = _handleDioError(e);
//       if (e.response?.statusCode == 401) {
//         gets.Get.offAllNamed(RoutesName.login);
//       }
//       return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
//     } catch (e) {
//       return Failure(code: 0, errorResponse: e.toString());
//     }
//   }
//
//   getAPICallAuth({
//     required String url,
//     required Map<String, dynamic> param,
//     bool? isRaw,
//     bool isData = false,
//   }) async {
//     var authenticationToken = gets.Get.find<UserViewModel>().authToken.value;
//     if (authenticationToken.isNotEmpty) {
//       try {
//         var response = await dio.get(
//           url,
//           queryParameters: isData ? null : param,
//           data: isData ? param : null,
//           options: Options(
//             responseType: ResponseType.json,
//             headers: {
//               HttpHeaders.acceptHeader: "application/json",
//               HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
//             },
//           ),
//         );
//         return Success(code: response.statusCode, response: response);
//       } on DioException catch (e) {
//         String errorMessage = _handleDioError(e);
//         if (e.response?.statusCode == 401) {
//           gets.Get.offAllNamed(RoutesName.login);
//         }
//         return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
//       } catch (e) {
//         return Failure(code: 0, errorResponse: e.toString());
//       }
//     } else {
//       gets.Get.offAllNamed(RoutesName.login);
//       return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
//     }
//   }
//
//   postAPICallAuth(
//       {required Map<String, dynamic> param, required String url, required ParamType paramType}) async {
//     var authenticationToken = gets.Get.find<UserViewModel>().authToken.value;
//     debugPrint("authentication: ${authenticationToken.toString()}");
//     if (authenticationToken.isNotEmpty) {
//       try {
//         var response = await dio.post(
//           url,
//           options: Options(
//             responseType: ResponseType.json,
//             headers: {
//               HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
//               HttpHeaders.contentTypeHeader:
//                   paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded",
//               HttpHeaders.acceptHeader:
//                   paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded"
//             },
//           ),
//           data: paramType == ParamType.raw ? json.encode(param) : param,
//         );
//         return Success(code: response.statusCode, response: response);
//       } on DioException catch (e) {
//         String errorMessage = _handleDioError(e);
//         if (e.response?.statusCode == 401) {
//           gets.Get.offAllNamed(RoutesName.login);
//         }
//         return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
//       } catch (e) {
//         return Failure(code: 0, errorResponse: e.toString());
//       }
//     } else {
//       gets.Get.offAllNamed(RoutesName.login);
//       return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
//     }
//   }
//
//   deleteAPICallAuth(
//       {required Map<String, dynamic> param, required String url, required ParamType paramType}) async {
//     var authenticationToken = gets.Get.find<UserViewModel>().authToken;
//     debugPrint("authentication: ${authenticationToken.toString()}");
//     if (authenticationToken.isNotEmpty) {
//       try {
//         var response = await dio.delete(
//           url,
//           options: Options(
//             responseType: ResponseType.json,
//             headers: {
//               HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
//               HttpHeaders.contentTypeHeader:
//                   paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded",
//               HttpHeaders.acceptHeader:
//                   paramType == ParamType.raw ? "application/json" : "application/x-www-form-urlencoded"
//             },
//           ),
//           data: paramType == ParamType.raw ? json.encode(param) : param,
//         );
//         return Success(code: response.statusCode, response: response);
//       } on DioException catch (e) {
//         String errorMessage = _handleDioError(e);
//         if (e.response?.statusCode == 401) {
//           gets.Get.offAllNamed(RoutesName.login);
//         }
//         return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
//       } catch (e) {
//         return Failure(code: 0, errorResponse: e.toString());
//       }
//     } else {
//       gets.Get.offAllNamed(RoutesName.login);
//       return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
//     }
//   }
//
//   Future<dynamic> postAPICallAuthFileUpload({
//     required Map<String, dynamic> param,
//     required String url,
//   }) async {
//     var authenticationToken = gets.Get.find<UserViewModel>().authToken;
//     debugPrint("authentication: ${authenticationToken.toString()}");
//     if (authenticationToken.isNotEmpty) {
//       try {
//         FormData formData = FormData();
//         for (var entry in param.entries) {
//           var key = entry.key;
//           var value = entry.value;
//           if ((key == "back_pic" || key == "side_pic" || key == "front_pic" || key == "profile_image") &&
//               value != null) {
//             formData.files.add(
//               MapEntry(
//                 key,
//                 await MultipartFile.fromFile(
//                   File(value).path,
//                   filename: File(value).path.split('/').last,
//                 ),
//               ),
//             );
//           } else if (key == "blood_test_report" && value != null) {
//             if (value is List<String>) {
//               for (var element in value) {
//                 formData.files.add(
//                   MapEntry(
//                     "$key[]",
//                     await MultipartFile.fromFile(
//                       File(element).path,
//                       filename: File(element).path.split('/').last,
//                     ),
//                   ),
//                 );
//               }
//             }
//           } else {
//             if (value != null) {
//               formData.fields.add(MapEntry(key, value.toString()));
//             }
//           }
//         }
//         formData.fields.add(const MapEntry("_method", "PUT"));
//         var response = await dio.post(
//           url,
//           options: Options(
//             responseType: ResponseType.json,
//             headers: {
//               HttpHeaders.authorizationHeader: "Bearer $authenticationToken",
//             },
//           ),
//           data: formData,
//         );
//         return Success(code: response.statusCode, response: response);
//       } on DioException catch (e) {
//         String errorMessage = _handleDioError(e);
//         if (e.response?.statusCode == 401) {
//           gets.Get.offAllNamed(RoutesName.login);
//         }
//         return Failure(code: e.response?.statusCode ?? 0, errorResponse: errorMessage);
//       } catch (e) {
//         return Failure(code: 0, errorResponse: e.toString());
//       }
//     } else {
//       gets.Get.offAllNamed(RoutesName.login);
//       return Failure(code: 401, errorResponse: "Unauthorized Request please login first");
//     }
//   }
//
//   String _handleDioError(DioException e) {
//     if (e.type == DioExceptionType.connectionTimeout) {
//       return "connection timeout";
//     }
//     if (e.type == DioExceptionType.connectionError && e.error is SocketException) {
//       return "No network found. Please check your internet connection.";
//     }
//     if (e.response != null) {
//       switch (e.response?.statusCode) {
//         case 400:
//           String mes = jsonDecode(e.response.toString())["message"] ?? "";
//           if (mes.isNotEmpty) {
//             return mes;
//           } else {
//             return "Bad request. Please check your input.";
//           }
//         case 401:
//           gets.Get.find<UserViewModel>().clearUser();
//           return "Unauthorized. Please check your credentials.";
//         case 403:
//
//           return "Forbidden. You don't have permission to access this resource.";
//         case 404:
//           var mes = jsonDecode(e.response.toString())["message"];
//           return mes;
//         case 500:
//           return "internal server error something went wrong in server side";
//         default:
//           return e.response?.data["message"] ?? "Something went wrong. Please try again.";
//       }
//     } else {
//       return e.message ?? "An unexpected error occurred.";
//     }
//   }
// }
