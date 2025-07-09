// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTaskModel _$UserTaskModelFromJson(Map<String, dynamic> json) =>
    UserTaskModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserTaskModelToJson(UserTaskModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      taskId: (json['task_id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      plan: json['plan'] == null
          ? null
          : Plan.fromJson(json['plan'] as Map<String, dynamic>),
      task: json['task'] == null
          ? null
          : Task.fromJson(json['task'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'task_id': instance.taskId,
      'plan_id': instance.planId,
      'lesson_id': instance.lessonId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'plan': instance.plan,
      'task': instance.task,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: (json['id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      startDatetime: json['start_datetime'] as String?,
      endDatetime: json['end_datetime'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'trainer_id': instance.trainerId,
      'name': instance.name,
      'description': instance.description,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'is_active': instance.isActive,
      'start_datetime': instance.startDatetime,
      'end_datetime': instance.endDatetime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: (json['id'] as num?)?.toInt(),
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      taskType: json['task_type'] as String?,
      stars: json['stars'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'lesson_id': instance.lessonId,
      'title': instance.title,
      'description': instance.description,
      'is_active': instance.isActive,
      'task_type': instance.taskType,
      'stars': instance.stars,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
