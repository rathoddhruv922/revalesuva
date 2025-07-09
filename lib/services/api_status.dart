import 'package:dio/dio.dart';

abstract class APIStatus {}

class Success implements APIStatus {
  int? code;
  Response? response;

  Success({this.code, this.response});
}

class Failure implements APIStatus {
  int? code;
  Object? errorResponse;

  Failure({this.code, this.errorResponse});
}
