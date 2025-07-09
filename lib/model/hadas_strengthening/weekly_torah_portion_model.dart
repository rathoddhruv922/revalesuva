// To parse this JSON data, do
//
//     final weeklyTorahPortionModel = weeklyTorahPortionModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'weekly_torah_portion_model.g.dart';

WeeklyTorahPortionModel weeklyTorahPortionModelFromJson(String str) => WeeklyTorahPortionModel.fromJson(json.decode(str));

String weeklyTorahPortionModelToJson(WeeklyTorahPortionModel data) => json.encode(data.toJson());

@JsonSerializable()
class WeeklyTorahPortionModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  WeeklyTorahPortionModel({
    this.status,
    this.message,
    this.data,
  });

  factory WeeklyTorahPortionModel.fromJson(Map<String, dynamic> json) => _$WeeklyTorahPortionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyTorahPortionModelToJson(this);
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
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.title,
    this.description,
    this.date,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
