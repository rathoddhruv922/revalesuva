// To parse this JSON data, do
//
//     final nutritionalInformationModel = nutritionalInformationModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'nutritional_information_model.g.dart';

NutritionalInformationModel nutritionalInformationModelFromJson(String str) =>
    NutritionalInformationModel.fromJson(json.decode(str));

String nutritionalInformationModelToJson(NutritionalInformationModel data) => json.encode(data.toJson());

@JsonSerializable()
class NutritionalInformationModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  NutritionalInformationModel({
    this.status,
    this.message,
    this.data,
  });

  factory NutritionalInformationModel.fromJson(Map<String, dynamic> json) => _$NutritionalInformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionalInformationModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
