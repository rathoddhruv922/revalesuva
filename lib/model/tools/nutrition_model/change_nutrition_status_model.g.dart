// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_nutrition_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeNutritionStatusModel _$ChangeNutritionStatusModelFromJson(
        Map<String, dynamic> json) =>
    ChangeNutritionStatusModel(
      date: json['date'] as String?,
      status: json['status'] as String?,
      nutritionData: (json['nutrition_data'] as List<dynamic>?)
          ?.map((e) => NutritionDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChangeNutritionStatusModelToJson(
        ChangeNutritionStatusModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'status': instance.status,
      'nutrition_data': instance.nutritionData,
    };

NutritionDatum _$NutritionDatumFromJson(Map<String, dynamic> json) =>
    NutritionDatum(
      nutritionId: (json['nutrition_id'] as num?)?.toInt(),
      mealType: json['meal_type'] as String?,
    );

Map<String, dynamic> _$NutritionDatumToJson(NutritionDatum instance) =>
    <String, dynamic>{
      'nutrition_id': instance.nutritionId,
      'meal_type': instance.mealType,
    };
