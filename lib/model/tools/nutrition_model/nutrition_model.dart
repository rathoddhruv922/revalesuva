// To parse this JSON data, do
//
//     final nutritionModel = nutritionModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'nutrition_model.g.dart';

NutritionModel nutritionModelFromJson(String str) => NutritionModel.fromJson(json.decode(str));

String nutritionModelToJson(NutritionModel data) => json.encode(data.toJson());

@JsonSerializable()
class NutritionModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  NutritionModel({
    this.status,
    this.message,
    this.data,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) => _$NutritionModelFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "nutrition_type")
  String? nutritionType;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "color")
  String? color;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.nutritionType,
    this.name,
    this.color,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
