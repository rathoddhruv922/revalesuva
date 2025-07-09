// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'task_model.g.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

@JsonSerializable()
class TaskModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  TaskModel({
    this.status,
    this.message,
    this.data,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}

@JsonSerializable()
class Datum {
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
  @JsonKey(name: "lesson")
  Lesson? lesson;

  Datum({
    this.id,
    this.lessonId,
    this.title,
    this.description,
    this.isActive,
    this.taskType,
    this.stars,
    this.createdAt,
    this.updatedAt,
    this.lesson,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Lesson {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "video")
  String? video;
  @JsonKey(name: "vimeo_video_id")
  String? vimeoVideoId;
  @JsonKey(name: "vimeo_video_hash")
  String? vimeoVideoHash;
  @JsonKey(name: "document")
  String? document;
  @JsonKey(name: "zoomlink")
  String? zoomlink;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Lesson({
    this.id,
    this.planId,
    this.title,
    this.description,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.document,
    this.zoomlink,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
