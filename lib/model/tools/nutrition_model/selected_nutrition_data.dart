// To parse this JSON data, do
//
//     final selectedNutritionData = selectedNutritionDataFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'selected_nutrition_data.g.dart';

SelectedNutritionData selectedNutritionDataFromJson(String str) => SelectedNutritionData.fromJson(json.decode(str));

String selectedNutritionDataToJson(SelectedNutritionData data) => json.encode(data.toJson());

@JsonSerializable()
class SelectedNutritionData {
  @JsonKey(name: "breakfast")
  NutritionType? breakfast;
  @JsonKey(name: "lunch")
  NutritionType? lunch;
  @JsonKey(name: "dinner")
  NutritionType? dinner;
  @JsonKey(name: "snacks")
  NutritionType? snacks;

  SelectedNutritionData({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snacks
  });

  factory SelectedNutritionData.fromJson(Map<String, dynamic> json) => _$SelectedNutritionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedNutritionDataToJson(this);
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
