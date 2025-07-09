// To parse this JSON data, do
//
//     final starsModel = starsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'stars_model.g.dart';

StarsModel starsModelFromJson(String str) => StarsModel.fromJson(json.decode(str));

String starsModelToJson(StarsModel data) => json.encode(data.toJson());

@JsonSerializable()
class StarsModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  StarsModel({
    this.status,
    this.message,
    this.data,
  });

  factory StarsModel.fromJson(Map<String, dynamic> json) => _$StarsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StarsModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "stars")
  List<Star>? stars;
  @JsonKey(name: "get_user_achievements")
  int? getUserAchievements;

  Data({
    this.stars,
    this.getUserAchievements,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Star {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "question")
  String? question;
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Star({
    this.id,
    this.question,
    this.answer,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Star.fromJson(Map<String, dynamic> json) => _$StarFromJson(json);

  Map<String, dynamic> toJson() => _$StarToJson(this);
}
