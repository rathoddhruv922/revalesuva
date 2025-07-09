// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_nutrition_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectedNutritionData _$SelectedNutritionDataFromJson(
        Map<String, dynamic> json) =>
    SelectedNutritionData(
      breakfast: json['breakfast'] == null
          ? null
          : NutritionType.fromJson(json['breakfast'] as Map<String, dynamic>),
      lunch: json['lunch'] == null
          ? null
          : NutritionType.fromJson(json['lunch'] as Map<String, dynamic>),
      dinner: json['dinner'] == null
          ? null
          : NutritionType.fromJson(json['dinner'] as Map<String, dynamic>),
      snacks: json['snacks'] == null
          ? null
          : NutritionType.fromJson(json['snacks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SelectedNutritionDataToJson(
        SelectedNutritionData instance) =>
    <String, dynamic>{
      'breakfast': instance.breakfast,
      'lunch': instance.lunch,
      'dinner': instance.dinner,
      'snacks': instance.snacks,
    };

NutritionType _$NutritionTypeFromJson(Map<String, dynamic> json) =>
    NutritionType(
      vegetables: json['vegetables'] == null
          ? null
          : Nutrition.fromJson(json['vegetables'] as Map<String, dynamic>),
      proteins: json['proteins'] == null
          ? null
          : Nutrition.fromJson(json['proteins'] as Map<String, dynamic>),
      carbohydrates: json['carbohydrates'] == null
          ? null
          : Nutrition.fromJson(json['carbohydrates'] as Map<String, dynamic>),
      fats: json['fats'] == null
          ? null
          : Nutrition.fromJson(json['fats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NutritionTypeToJson(NutritionType instance) =>
    <String, dynamic>{
      'vegetables': instance.vegetables,
      'proteins': instance.proteins,
      'carbohydrates': instance.carbohydrates,
      'fats': instance.fats,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      nutritionId: (json['nutrition_id'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      nutritionName: json['nutrition'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'nutrition_id': instance.nutritionId,
      'nutrition': instance.nutritionName,
      'status': instance.status,
    };
