// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'login_model.g.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

@JsonSerializable()
class LoginModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: "is_subscribed_to_plan")
  bool? isSubscribedToPlan;
  @JsonKey(name: "is_subscribed_to_program")
  bool? isSubscribedToProgram;
  @JsonKey(name: "message")
  String? message;

  Data({
    this.token,
    this.role,
    this.isSubscribedToPlan,
    this.isSubscribedToProgram,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
