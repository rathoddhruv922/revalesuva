// To parse this JSON data, do
//
//     final lessonsModel = lessonsModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'lessons_model.g.dart';

LessonsModel lessonsModelFromJson(String str) => LessonsModel.fromJson(json.decode(str));

String lessonsModelToJson(LessonsModel data) => json.encode(data.toJson());

@JsonSerializable()
class LessonsModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  LessonsModel({
    this.status,
    this.message,
    this.data,
  });

  factory LessonsModel.fromJson(Map<String, dynamic> json) => _$LessonsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonsModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "days")
  int? days;
  @JsonKey(name: "video")
  String? video;
  @JsonKey(name: "vimeo_video_id")
  String? vimeoVideoId;
  @JsonKey(name: "vimeo_video_hash")
  String? vimeoVideoHash;
  @JsonKey(name: "thumbnail_image")
  String? thumbnailImage;
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
  @JsonKey(name: "user_lessons")
  UserLessons? userLessons;
  @JsonKey(name: "days_since_plan_created")
  int? daysSincePlanCreated;

  Datum({
    this.id,
    this.planId,
    this.title,
    this.description,
    this.days,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.thumbnailImage,
    this.document,
    this.zoomlink,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.userLessons,
    this.daysSincePlanCreated,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class UserLessons {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "lesson_id")
  int? lessonId;
  @JsonKey(name: "watch_status")
  String? watchStatus;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  UserLessons({
    this.id,
    this.userId,
    this.lessonId,
    this.watchStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory UserLessons.fromJson(Map<String, dynamic> json) => _$UserLessonsFromJson(json);

  Map<String, dynamic> toJson() => _$UserLessonsToJson(this);
}
