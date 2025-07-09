// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessons_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonsModel _$LessonsModelFromJson(Map<String, dynamic> json) => LessonsModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonsModelToJson(LessonsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      days: (json['days'] as num?)?.toInt(),
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      thumbnailImage: json['thumbnail_image'] as String?,
      document: json['document'] as String?,
      zoomlink: json['zoomlink'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      userLessons: json['user_lessons'] == null
          ? null
          : UserLessons.fromJson(json['user_lessons'] as Map<String, dynamic>),
      daysSincePlanCreated: (json['days_since_plan_created'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'plan_id': instance.planId,
      'title': instance.title,
      'description': instance.description,
      'days': instance.days,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'thumbnail_image': instance.thumbnailImage,
      'document': instance.document,
      'zoomlink': instance.zoomlink,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user_lessons': instance.userLessons,
      'days_since_plan_created': instance.daysSincePlanCreated,
    };

UserLessons _$UserLessonsFromJson(Map<String, dynamic> json) => UserLessons(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      watchStatus: json['watch_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$UserLessonsToJson(UserLessons instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'lesson_id': instance.lessonId,
      'watch_status': instance.watchStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
