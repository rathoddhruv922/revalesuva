// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      taskType: json['task_type'] as String?,
      stars: json['stars'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      lesson: json['lesson'] == null
          ? null
          : Lesson.fromJson(json['lesson'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'lesson_id': instance.lessonId,
      'title': instance.title,
      'description': instance.description,
      'is_active': instance.isActive,
      'task_type': instance.taskType,
      'stars': instance.stars,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'lesson': instance.lesson,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: (json['id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      document: json['document'] as String?,
      zoomlink: json['zoomlink'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'plan_id': instance.planId,
      'title': instance.title,
      'description': instance.description,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'document': instance.document,
      'zoomlink': instance.zoomlink,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
