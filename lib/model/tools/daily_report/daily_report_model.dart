// To parse this JSON data, do
//
//     final dailyReportModel = dailyReportModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'daily_report_model.g.dart';

DailyReportModel dailyReportModelFromJson(String str) => DailyReportModel.fromJson(json.decode(str));

String dailyReportModelToJson(DailyReportModel data) => json.encode(data.toJson());

@JsonSerializable()
class DailyReportModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  DailyReportModel({
    this.status,
    this.message,
    this.data,
  });

  factory DailyReportModel.fromJson(Map<String, dynamic> json) => _$DailyReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportModelToJson(this);
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
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "date")
  DateTime? date;

  Datum({
    this.userId,
    this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
