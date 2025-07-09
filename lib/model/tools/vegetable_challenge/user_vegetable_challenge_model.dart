// To parse this JSON data, do
//
//     final userVegetableChallengeModel = userVegetableChallengeModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_vegetable_challenge_model.g.dart';

UserVegetableChallengeModel userVegetableChallengeModelFromJson(String str) => UserVegetableChallengeModel.fromJson(json.decode(str));

String userVegetableChallengeModelToJson(UserVegetableChallengeModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserVegetableChallengeModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  UserVegetableChallengeModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserVegetableChallengeModel.fromJson(Map<String, dynamic> json) => _$UserVegetableChallengeModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserVegetableChallengeModelToJson(this);
}


@JsonSerializable()
class Datum {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "nutrition_id")
  int? nutritionId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "nutrition")
  Nutrition? nutrition;

  Datum({
    this.userId,
    this.nutritionId,
    this.date,
    this.nutrition,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Nutrition {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "color")
  String? color;

  Nutrition({
    this.id,
    this.name,
    this.color,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => _$NutritionFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}
