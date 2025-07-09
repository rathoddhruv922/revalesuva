// To parse this JSON data, do
//
//     final fastingCalculatorModel = fastingCalculatorModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'fasting_calculator_model.g.dart';

FastingCalculatorModel fastingCalculatorModelFromJson(String str) =>
    FastingCalculatorModel.fromJson(json.decode(str));

String fastingCalculatorModelToJson(FastingCalculatorModel data) => json.encode(data.toJson());

@JsonSerializable()
class FastingCalculatorModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  FastingCalculatorModel({
    this.status,
    this.message,
    this.data,
  });

  factory FastingCalculatorModel.fromJson(Map<String, dynamic> json) =>
      _$FastingCalculatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$FastingCalculatorModelToJson(this);
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
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "no_of_fasting_hours")
  int? noOfFastingHours;
  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "end_time")
  String? endTime;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.date,
    this.noOfFastingHours,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
