  // To parse this JSON data, do
//
//     final programModel = programModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'program_model.g.dart';

ProgramModel programModelFromJson(String str) => ProgramModel.fromJson(json.decode(str));

String programModelToJson(ProgramModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProgramModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  ProgramModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) => _$ProgramModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramModelToJson(this);
}

@JsonSerializable()
class Datum {
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

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
