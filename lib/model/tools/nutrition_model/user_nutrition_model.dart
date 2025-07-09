// To parse this JSON data, do
//
//     final userNutritionModel = userNutritionModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_nutrition_model.g.dart';

UserNutritionModel userNutritionModelFromJson(String str) => UserNutritionModel.fromJson(json.decode(str));

String userNutritionModelToJson(UserNutritionModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserNutritionModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  UserNutritionModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserNutritionModel.fromJson(Map<String, dynamic> json) => _$UserNutritionModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserNutritionModelToJson(this);
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
  dynamic createdAt;
  @JsonKey(name: "updated_at")
  dynamic updatedAt;
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
  dynamic contactNumber;

  Trainer({
    this.id,
    this.name,
    this.email,
    this.contactNumber,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => _$TrainerFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}
