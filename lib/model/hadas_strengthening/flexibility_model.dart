// To parse this JSON data, do
//
//     final flexibilityModel = flexibilityModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'flexibility_model.g.dart';

FlexibilityModel flexibilityModelFromJson(String str) => FlexibilityModel.fromJson(json.decode(str));

String flexibilityModelToJson(FlexibilityModel data) => json.encode(data.toJson());

@JsonSerializable()
class FlexibilityModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  FlexibilityModel({
    this.status,
    this.message,
    this.data,
  });

  factory FlexibilityModel.fromJson(Map<String, dynamic> json) => _$FlexibilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlexibilityModelToJson(this);
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
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "video")
  String? video;
  @JsonKey(name: "vimeo_video_id")
  String? vimeoVideoId;
  @JsonKey(name: "vimeo_video_hash")
  String? vimeoVideoHash;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "category")
  Category? category;

  Datum({
    this.id,
    this.categoryId,
    this.title,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.category,

  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Category {
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

  Category({
    this.id,
    this.flexibilityType,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
