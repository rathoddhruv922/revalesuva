// To parse this JSON data, do
//
//     final programUserSummaryModel = programUserSummaryModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'program_user_summary_model.g.dart';

ProgramUserSummaryModel programUserSummaryModelFromJson(String str) => ProgramUserSummaryModel.fromJson(json.decode(str));

String programUserSummaryModelToJson(ProgramUserSummaryModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProgramUserSummaryModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  ProgramUserSummaryModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProgramUserSummaryModel.fromJson(Map<String, dynamic> json) => _$ProgramUserSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramUserSummaryModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "plan_summary_report_id")
  int? planSummaryReportId;
  @JsonKey(name: "page_type")
  dynamic pageType;
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "sub_answer")
  String? subAnswer;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "plan_summary_report")
  PlanSummaryReport? planSummaryReport;

  Datum({
    this.id,
    this.userId,
    this.planSummaryReportId,
    this.pageType,
    this.answer,
    this.subAnswer,
    this.createdAt,
    this.updatedAt,
    this.planSummaryReport,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class PlanSummaryReport {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "page_type")
  String? pageType;
  @JsonKey(name: "question1")
  String? question1;
  @JsonKey(name: "question2")
  String? question2;
  @JsonKey(name: "answer_type")
  String? answerType;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  PlanSummaryReport({
    this.id,
    this.pageType,
    this.question1,
    this.question2,
    this.answerType,
    this.order,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PlanSummaryReport.fromJson(Map<String, dynamic> json) => _$PlanSummaryReportFromJson(json);

  Map<String, dynamic> toJson() => _$PlanSummaryReportToJson(this);
}
