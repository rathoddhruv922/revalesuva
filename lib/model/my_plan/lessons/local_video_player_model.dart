// To parse this JSON data, do
//
//     final localVideoPlayerModel = localVideoPlayerModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_video_player_model.g.dart';

LocalVideoPlayerModel localVideoPlayerModelFromJson(String str) =>
    LocalVideoPlayerModel.fromJson(json.decode(str));

String localVideoPlayerModelToJson(LocalVideoPlayerModel data) => json.encode(data.toJson());

@HiveType(typeId: 8)
@JsonSerializable()
class LocalVideoPlayerModel extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "id")
  String? id;
  @HiveField(3)
  @JsonKey(name: "video_url")
  String? videoUrl;
  @HiveField(5)
  @JsonKey(name: "total_length")
  String? totalLength;
  @HiveField(7)
  @JsonKey(name: "played_length")
  String? playedLength;
  @HiveField(9)
  @JsonKey(name: "status")
  String? status;

  LocalVideoPlayerModel({
    this.id,
    this.videoUrl,
    this.totalLength,
    this.playedLength,
    this.status,
  });

  factory LocalVideoPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$LocalVideoPlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalVideoPlayerModelToJson(this);
}
