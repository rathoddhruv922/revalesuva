// To parse this JSON data, do
//
//     final supportServiceModel = supportServiceModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'support_service_model.g.dart';

SupportServiceModel supportServiceModelFromJson(String str) => SupportServiceModel.fromJson(json.decode(str));

String supportServiceModelToJson(SupportServiceModel data) => json.encode(data.toJson());

@JsonSerializable()
class SupportServiceModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  SupportServiceModel({
    this.status,
    this.message,
    this.data,
  });

  factory SupportServiceModel.fromJson(Map<String, dynamic> json) => _$SupportServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportServiceModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "help_question")
  String? helpQuestion;
  @JsonKey(name: "help_details")
  String? helpDetails;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  int? id;

  Data({
    this.userId,
    this.helpQuestion,
    this.helpDetails,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
