// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vegetable_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVegetableChallengeModel _$UserVegetableChallengeModelFromJson(
        Map<String, dynamic> json) =>
    UserVegetableChallengeModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserVegetableChallengeModelToJson(
        UserVegetableChallengeModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      userId: (json['user_id'] as num?)?.toInt(),
      nutritionId: (json['nutrition_id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      nutrition: json['nutrition'] == null
          ? null
          : Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'user_id': instance.userId,
      'nutrition_id': instance.nutritionId,
      'date': instance.date?.toIso8601String(),
      'nutrition': instance.nutrition,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
    };
