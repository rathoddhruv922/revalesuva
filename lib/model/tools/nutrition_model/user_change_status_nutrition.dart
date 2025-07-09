// To parse this JSON data, do
//
//     final userChangeStatusNutrition = userChangeStatusNutritionFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_change_status_nutrition.g.dart';

UserChangeStatusNutrition userChangeStatusNutritionFromJson(String str) => UserChangeStatusNutrition.fromJson(json.decode(str));

String userChangeStatusNutritionToJson(UserChangeStatusNutrition data) => json.encode(data.toJson());

@JsonSerializable()
class UserChangeStatusNutrition {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "is_checked")
  bool? isChecked;
  @JsonKey(name: "nutrition_data")
  List<NutritionDatum>? nutritionData;

  UserChangeStatusNutrition({
    this.date,
    this.isChecked,
    this.nutritionData,
  });

  factory UserChangeStatusNutrition.fromJson(Map<String, dynamic> json) => _$UserChangeStatusNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$UserChangeStatusNutritionToJson(this);
}

@JsonSerializable()
class NutritionDatum {
  @JsonKey(name: "nutrition_id")
  int? nutritionId;

  NutritionDatum({
    this.nutritionId,
  });

  factory NutritionDatum.fromJson(Map<String, dynamic> json) => _$NutritionDatumFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionDatumToJson(this);
}
