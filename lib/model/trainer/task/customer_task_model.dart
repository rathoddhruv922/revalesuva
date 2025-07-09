// To parse this JSON data, do
//
//     final customerTaskModel = customerTaskModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'customer_task_model.g.dart';

CustomerTaskModel customerTaskModelFromJson(String str) => CustomerTaskModel.fromJson(json.decode(str));

String customerTaskModelToJson(CustomerTaskModel data) => json.encode(data.toJson());

@JsonSerializable()
class CustomerTaskModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  CustomerTaskModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerTaskModel.fromJson(Map<String, dynamic> json) => _$CustomerTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTaskModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "task_id")
  int? taskId;
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "lesson_id")
  int? lessonId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "plan")
  Plan? plan;
  @JsonKey(name: "task")
  Task? task;

  Datum({
    this.id,
    this.userId,
    this.taskId,
    this.planId,
    this.lessonId,
    this.createdAt,
    this.updatedAt,
    this.plan,
    this.task,
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
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "start_datetime")
  String? startDatetime;
  @JsonKey(name: "end_datetime")
  String? endDatetime;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Plan({
    this.id,
    this.trainerId,
    this.name,
    this.description,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.isActive,
    this.startDatetime,
    this.endDatetime,
    this.createdAt,
    this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class Task {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "lesson_id")
  int? lessonId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "task_type")
  String? taskType;
  @JsonKey(name: "stars")
  String? stars;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Task({
    this.id,
    this.lessonId,
    this.title,
    this.description,
    this.isActive,
    this.taskType,
    this.stars,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
