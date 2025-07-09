// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_change_status_nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChangeStatusNutrition _$UserChangeStatusNutritionFromJson(
        Map<String, dynamic> json) =>
    UserChangeStatusNutrition(
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      isChecked: json['is_checked'] as bool?,
      nutritionData: (json['nutrition_data'] as List<dynamic>?)
          ?.map((e) => NutritionDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserChangeStatusNutritionToJson(
        UserChangeStatusNutrition instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'is_checked': instance.isChecked,
      'nutrition_data': instance.nutritionData,
    };

NutritionDatum _$NutritionDatumFromJson(Map<String, dynamic> json) =>
    NutritionDatum(
      nutritionId: (json['nutrition_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NutritionDatumToJson(NutritionDatum instance) =>
    <String, dynamic>{
      'nutrition_id': instance.nutritionId,
    };
