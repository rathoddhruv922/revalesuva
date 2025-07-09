// To parse this JSON data, do
//
//     final myAchievementsModel = myAchievementsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'my_achievements_model.g.dart';

MyAchievementsModel myAchievementsModelFromJson(String str) => MyAchievementsModel.fromJson(json.decode(str));

String myAchievementsModelToJson(MyAchievementsModel data) => json.encode(data.toJson());

@JsonSerializable()
class MyAchievementsModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  MyAchievementsModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyAchievementsModel.fromJson(Map<String, dynamic> json) => _$MyAchievementsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyAchievementsModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "success_type")
  String? successType;
  @JsonKey(name: "task_to_achieve")
  String? taskToAchieve;
  @JsonKey(name: "condition_type")
  String? conditionType;
  @JsonKey(name: "task_value")
  String? taskValue;
  @JsonKey(name: "star")
  int? star;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "is_achived")
  String? isAchived;

  Datum({
    this.id,
    this.successType,
    this.taskToAchieve,
    this.conditionType,
    this.taskValue,
    this.star,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.isAchived,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
