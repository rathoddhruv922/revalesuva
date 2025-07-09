// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_user_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreUserChallengeModel _$StoreUserChallengeModelFromJson(
        Map<String, dynamic> json) =>
    StoreUserChallengeModel(
      date: json['date'] as String?,
      nutritionData: (json['nutrition_data'] as List<dynamic>?)
          ?.map((e) => NutritionDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreUserChallengeModelToJson(
        StoreUserChallengeModel instance) =>
    <String, dynamic>{
      'date': instance.date,
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
