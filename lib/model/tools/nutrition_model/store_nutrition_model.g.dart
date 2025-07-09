// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_nutrition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreNutritionModel _$StoreNutritionModelFromJson(Map<String, dynamic> json) =>
    StoreNutritionModel(
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      nutritionData: (json['nutrition_data'] as List<dynamic>?)
          ?.map((e) => NutritionDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$StoreNutritionModelToJson(
        StoreNutritionModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'trainer_id': instance.trainerId,
      'nutrition_data': instance.nutritionData,
    };

NutritionDatum _$NutritionDatumFromJson(Map<String, dynamic> json) =>
    NutritionDatum(
      nutritionId: (json['nutrition_id'] as num?)?.toInt(),
      foodType: json['food_type'] as String?,
    );

Map<String, dynamic> _$NutritionDatumToJson(NutritionDatum instance) =>
    <String, dynamic>{
      'nutrition_id': instance.nutritionId,
      'food_type': instance.foodType,
    };
