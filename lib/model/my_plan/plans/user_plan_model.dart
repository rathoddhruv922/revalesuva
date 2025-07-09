// To parse this JSON data, do
//
//     final userPlanModel = userPlanModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_plan_model.g.dart';

UserPlanModel userPlanModelFromJson(String str) => UserPlanModel.fromJson(json.decode(str));

String userPlanModelToJson(UserPlanModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserPlanModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  UserPlanModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserPlanModel.fromJson(Map<String, dynamic> json) => _$UserPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPlanModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "plan_cycle_id")
  int? planCycleId;
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "plan")
  Plan? plan;

  Datum({
    this.id,
    this.userId,
    this.planId,
    this.planCycleId,
    this.trainerId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.plan,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Plan {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "video")
  String? video;
  @JsonKey(name: "vimeo_video_id")
  String? vimeoVideoId;
  @JsonKey(name: "vimeo_video_hash")
  String? vimeoVideoHash;
  @JsonKey(name: "week_days")
  String? weekDays;
  @JsonKey(name: "repeat")
  int? repeat;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "active_day")
  String? activeDay;
  @JsonKey(name: "settings")
  Settings? settings;
  @JsonKey(name: "plan_cycles")
  List<PlanCycle>? planCycles;

  Plan({
    this.id,
    this.trainerId,
    this.name,
    this.description,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.weekDays,
    this.repeat,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.activeDay,
    this.settings,
    this.planCycles,

  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class PlanCycle {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  PlanCycle({
    this.id,
    this.planId,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PlanCycle.fromJson(Map<String, dynamic> json) => _$PlanCycleFromJson(json);

  Map<String, dynamic> toJson() => _$PlanCycleToJson(this);
}

@JsonSerializable()
class Settings {
  @JsonKey(name: "vegetables_challenge")
  DailyReport? vegetablesChallenge;
  @JsonKey(name: "measurement")
  DailyReport? measurement;
  @JsonKey(name: "weight_module")
  DailyReport? weightModule;
  @JsonKey(name: "fasting_module")
  DailyReport? fastingModule;
  @JsonKey(name: "period_module")
  DailyReport? periodModule;
  @JsonKey(name: "weekly_report")
  DailyReport? weeklyReport;
  @JsonKey(name: "daily_report")
  DailyReport? dailyReport;
  @JsonKey(name: "lesson_summary")
  DailyReport? lessonSummary;

  Settings({
    this.vegetablesChallenge,
    this.measurement,
    this.weightModule,
    this.fastingModule,
    this.periodModule,
    this.weeklyReport,
    this.dailyReport,
    this.lessonSummary,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}

@JsonSerializable()
class DailyReport {
  @JsonKey(name: "day")
  String? day;

  DailyReport({
    this.day,
  });

  factory DailyReport.fromJson(Map<String, dynamic> json) => _$DailyReportFromJson(json);

  Map<String, dynamic> toJson() => _$DailyReportToJson(this);
}
