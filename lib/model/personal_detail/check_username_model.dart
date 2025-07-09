// To parse this JSON data, do
//
//     final checkUsernameModel = checkUsernameModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'check_username_model.g.dart';

CheckUsernameModel checkUsernameModelFromJson(String str) => CheckUsernameModel.fromJson(json.decode(str));

String checkUsernameModelToJson(CheckUsernameModel data) => json.encode(data.toJson());

@JsonSerializable()
class CheckUsernameModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;

  CheckUsernameModel({
    this.status,
    this.message,
  });

  factory CheckUsernameModel.fromJson(Map<String, dynamic> json) => _$CheckUsernameModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckUsernameModelToJson(this);
}
