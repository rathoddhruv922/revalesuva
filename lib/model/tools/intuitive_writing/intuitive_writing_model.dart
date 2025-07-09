// To parse this JSON data, do
//
//     final intuitiveWritingModel = intuitiveWritingModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'intuitive_writing_model.g.dart';

IntuitiveWritingModel intuitiveWritingModelFromJson(String str) => IntuitiveWritingModel.fromJson(json.decode(str));

String intuitiveWritingModelToJson(IntuitiveWritingModel data) => json.encode(data.toJson());

@JsonSerializable()
class IntuitiveWritingModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  IntuitiveWritingModel({
    this.status,
    this.message,
    this.data,
  });

  factory IntuitiveWritingModel.fromJson(Map<String, dynamic> json) => _$IntuitiveWritingModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntuitiveWritingModelToJson(this);
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
  @JsonKey(name: "user_id")
  int? userId;
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
    this.userId,
    this.description,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
