// To parse this JSON data, do
//
//     final flexibilityCategoryModel = flexibilityCategoryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'flexibility_category_model.g.dart';

FlexibilityCategoryModel flexibilityCategoryModelFromJson(String str) => FlexibilityCategoryModel.fromJson(json.decode(str));

String flexibilityCategoryModelToJson(FlexibilityCategoryModel data) => json.encode(data.toJson());

@JsonSerializable()
class FlexibilityCategoryModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  FlexibilityCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory FlexibilityCategoryModel.fromJson(Map<String, dynamic> json) => _$FlexibilityCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlexibilityCategoryModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "total_items")
  int? totalItems;
  @JsonKey(name: "data")
  List<Datum>? data;

  Data({
    this.currentPage,
    this.totalPages,
    this.perPage,
    this.totalItems,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "flexibility_type")
  String? flexibilityType;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.flexibilityType,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
