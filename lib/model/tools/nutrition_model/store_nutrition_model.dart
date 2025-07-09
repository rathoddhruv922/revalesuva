// To parse this JSON data, do
//
//     final storeNutritionModel = storeNutritionModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'store_nutrition_model.g.dart';

StoreNutritionModel storeNutritionModelFromJson(String str) => StoreNutritionModel.fromJson(json.decode(str));

String storeNutritionModelToJson(StoreNutritionModel data) => json.encode(data.toJson());

@JsonSerializable()
class StoreNutritionModel {
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "nutrition_data")
  List<NutritionDatum>? nutritionData;

  StoreNutritionModel({
    this.trainerId,
    this.nutritionData,
    this.date
  });

  factory StoreNutritionModel.fromJson(Map<String, dynamic> json) => _$StoreNutritionModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreNutritionModelToJson(this);
}

@JsonSerializable()
class NutritionDatum {
  @JsonKey(name: "nutrition_id")
  int? nutritionId;
  @JsonKey(name: "food_type")
  String? foodType;

  NutritionDatum({
    this.nutritionId,
    this.foodType,
  });

  factory NutritionDatum.fromJson(Map<String, dynamic> json) => _$NutritionDatumFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionDatumToJson(this);
}
