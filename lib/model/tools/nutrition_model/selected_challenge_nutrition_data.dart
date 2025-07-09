// To parse this JSON data, do
//
//     final selectedChallengeNutritionData = selectedChallengeNutritionDataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'selected_challenge_nutrition_data.g.dart';

SelectedChallengeNutritionData selectedChallengeNutritionDataFromJson(String str) => SelectedChallengeNutritionData.fromJson(json.decode(str));

String selectedChallengeNutritionDataToJson(SelectedChallengeNutritionData data) => json.encode(data.toJson());

@JsonSerializable()
class SelectedChallengeNutritionData {
  @JsonKey(name: "breakfast")
  NutritionType? breakfast;
  @JsonKey(name: "lunch")
  NutritionType? lunch;
  @JsonKey(name: "dinner")
  NutritionType? dinner;
  @JsonKey(name: "snacks")
  NutritionType? snacks;

  SelectedChallengeNutritionData({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snacks
  });

  factory SelectedChallengeNutritionData.fromJson(Map<String, dynamic> json) => _$SelectedChallengeNutritionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedChallengeNutritionDataToJson(this);
}

@JsonSerializable()
class NutritionType {
  @JsonKey(name: "vegetables")
  Nutrition? vegetables;
  @JsonKey(name: "proteins")
  Nutrition? proteins;
  @JsonKey(name: "carbohydrates")
  Nutrition? carbohydrates;
  @JsonKey(name: "fats")
  Nutrition? fats;

  NutritionType({
    this.vegetables,
    this.proteins,
    this.carbohydrates,
    this.fats,
  });

  factory NutritionType.fromJson(Map<String, dynamic> json) => _$NutritionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionTypeToJson(this);
}

@JsonSerializable()
class Nutrition {
  @JsonKey(name: "nutrition_id")
  List<int>? nutritionId;
  @JsonKey(name: "nutrition")
  String? nutritionName;
  @JsonKey(name: "status")
  String? status;

  Nutrition({
    this.nutritionId,
    this.nutritionName,
    this.status,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => _$NutritionFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}
