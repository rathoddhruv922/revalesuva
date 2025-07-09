// To parse this JSON data, do
//
//     final changeNutritionStatusModel = changeNutritionStatusModelFromJson(jsonString);
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'change_nutrition_status_model.g.dart';

ChangeNutritionStatusModel changeNutritionStatusModelFromJson(String str) =>
    ChangeNutritionStatusModel.fromJson(json.decode(str));

String changeNutritionStatusModelToJson(ChangeNutritionStatusModel data) => json.encode(data.toJson());

@JsonSerializable()
class ChangeNutritionStatusModel {
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "nutrition_data")
  List<NutritionDatum>? nutritionData;

  ChangeNutritionStatusModel({
    this.date,
    this.status,
    this.nutritionData,
  });

  factory ChangeNutritionStatusModel.fromJson(Map<String, dynamic> json) => _$ChangeNutritionStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeNutritionStatusModelToJson(this);
}

@JsonSerializable()
class NutritionDatum {
  @JsonKey(name: "nutrition_id")
  int? nutritionId;
  @JsonKey(name: "meal_type")
  String? mealType;

  NutritionDatum({
    this.nutritionId,
    this.mealType
  });

  factory NutritionDatum.fromJson(Map<String, dynamic> json) => _$NutritionDatumFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionDatumToJson(this);
}
