// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_daily_nutrition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDailyNutritionModel _$CustomerDailyNutritionModelFromJson(
        Map<String, dynamic> json) =>
    CustomerDailyNutritionModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerDailyNutritionModelToJson(
        CustomerDailyNutritionModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      nutritionId: (json['nutrition_id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      foodType: json['food_type'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      nutrition: json['nutrition'] == null
          ? null
          : Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
      trainer: json['trainer'] == null
          ? null
          : Trainer.fromJson(json['trainer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'nutrition_id': instance.nutritionId,
      'trainer_id': instance.trainerId,
      'date': instance.date?.toIso8601String(),
      'food_type': instance.foodType,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'nutrition': instance.nutrition,
      'trainer': instance.trainer,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) => Nutrition(
      id: (json['id'] as num?)?.toInt(),
      nutritionType: json['nutrition_type'] as String?,
      name: json['name'] as String?,
      color: json['color'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'id': instance.id,
      'nutrition_type': instance.nutritionType,
      'name': instance.name,
      'color': instance.color,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
    );

Map<String, dynamic> _$TrainerToJson(Trainer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'contact_number': instance.contactNumber,
    };
