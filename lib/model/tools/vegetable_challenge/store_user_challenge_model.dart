// To parse this JSON data, do
//
//     final storeUserChallengeModel = storeUserChallengeModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'store_user_challenge_model.g.dart';

StoreUserChallengeModel storeUserChallengeModelFromJson(String str) => StoreUserChallengeModel.fromJson(json.decode(str));

String storeUserChallengeModelToJson(StoreUserChallengeModel data) => json.encode(data.toJson());

@JsonSerializable()
class StoreUserChallengeModel {
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "nutrition_data")
  List<NutritionDatum>? nutritionData;

  StoreUserChallengeModel({
    this.date,
    this.nutritionData,
  });

  factory StoreUserChallengeModel.fromJson(Map<String, dynamic> json) => _$StoreUserChallengeModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreUserChallengeModelToJson(this);
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
