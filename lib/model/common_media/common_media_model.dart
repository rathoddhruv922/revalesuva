// To parse this JSON data, do
//
//     final commonMediaModel = commonMediaModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'common_media_model.g.dart';

CommonMediaModel commonMediaModelFromJson(String str) => CommonMediaModel.fromJson(json.decode(str));

String commonMediaModelToJson(CommonMediaModel data) => json.encode(data.toJson());

@JsonSerializable()
class CommonMediaModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  CommonMediaModel({
    this.status,
    this.message,
    this.data,
  });

  factory CommonMediaModel.fromJson(Map<String, dynamic> json) => _$CommonMediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonMediaModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "media_url")
  String? mediaUrl;
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

  Datum({
    this.id,
    this.name,
    this.slug,
    this.mediaUrl,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
