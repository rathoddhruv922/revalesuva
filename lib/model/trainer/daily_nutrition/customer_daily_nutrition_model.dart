// To parse this JSON data, do
//
//     final customerDailyNutritionModel = customerDailyNutritionModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'customer_daily_nutrition_model.g.dart';

CustomerDailyNutritionModel customerDailyNutritionModelFromJson(String str) => CustomerDailyNutritionModel.fromJson(json.decode(str));

String customerDailyNutritionModelToJson(CustomerDailyNutritionModel data) => json.encode(data.toJson());

@JsonSerializable()
class CustomerDailyNutritionModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  CustomerDailyNutritionModel({
    this.status,
    this.message,
    this.data,
  });

  factory CustomerDailyNutritionModel.fromJson(Map<String, dynamic> json) => _$CustomerDailyNutritionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDailyNutritionModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "nutrition_id")
  int? nutritionId;
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "food_type")
  String? foodType;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "nutrition")
  Nutrition? nutrition;
  @JsonKey(name: "trainer")
  Trainer? trainer;

  Datum({
    this.id,
    this.userId,
    this.nutritionId,
    this.trainerId,
    this.date,
    this.foodType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.nutrition,
    this.trainer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Nutrition {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "nutrition_type")
  String? nutritionType;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "color")
  String? color;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Nutrition({
    this.id,
    this.nutritionType,
    this.name,
    this.color,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => _$NutritionFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}

@JsonSerializable()
class Trainer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "contact_number")
  String? contactNumber;

  Trainer({
    this.id,
    this.name,
    this.email,
    this.contactNumber,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => _$TrainerFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}
