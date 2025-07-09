// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_achievements_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAchievementsModel _$MyAchievementsModelFromJson(Map<String, dynamic> json) =>
    MyAchievementsModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyAchievementsModelToJson(
        MyAchievementsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      successType: json['success_type'] as String?,
      taskToAchieve: json['task_to_achieve'] as String?,
      conditionType: json['condition_type'] as String?,
      taskValue: json['task_value'] as String?,
      star: (json['star'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isAchived: json['is_achived'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'success_type': instance.successType,
      'task_to_achieve': instance.taskToAchieve,
      'condition_type': instance.conditionType,
      'task_value': instance.taskValue,
      'star': instance.star,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_achived': instance.isAchived,
    };
