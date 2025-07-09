// To parse this JSON data, do
//
//     final contentLibrariesModel = contentLibrariesModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'content_libraries_model.g.dart';

ContentLibrariesModel contentLibrariesModelFromJson(String str) => ContentLibrariesModel.fromJson(json.decode(str));

String contentLibrariesModelToJson(ContentLibrariesModel data) => json.encode(data.toJson());

@JsonSerializable()
class ContentLibrariesModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  ContentLibrariesModel({
    this.status,
    this.message,
    this.data,
  });

  factory ContentLibrariesModel.fromJson(Map<String, dynamic> json) => _$ContentLibrariesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentLibrariesModelToJson(this);
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
  @JsonKey(name: "plan_id")
  int? planId;
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
  @JsonKey(name: "plan")
  Plan? plan;

  Datum({
    this.id,
    this.planId,
    this.title,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.isActive,
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
