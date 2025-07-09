// To parse this JSON data, do
//
//     final userProgramModel = userProgramModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_program_model.g.dart';

UserProgramModel userProgramModelFromJson(String str) => UserProgramModel.fromJson(json.decode(str));

String userProgramModelToJson(UserProgramModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserProgramModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  UserProgramModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserProgramModel.fromJson(Map<String, dynamic> json) => _$UserProgramModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProgramModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "program_id")
  int? programId;
  @JsonKey(name: "scheduled_id")
  int? scheduledId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "program")
  Program? program;

  Datum({
    this.id,
    this.userId,
    this.programId,
    this.scheduledId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.program,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Program {
  @JsonKey(name: "id")
  int? id;
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
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;
  @JsonKey(name: "days")
  String? days;
  @JsonKey(name: "repeat")
  int? repeat;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Program({
    this.id,
    this.name,
    this.description,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.startDate,
    this.endDate,
    this.days,
    this.repeat,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}
