// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_libraries_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentLibrariesModel _$ContentLibrariesModelFromJson(
        Map<String, dynamic> json) =>
    ContentLibrariesModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentLibrariesModelToJson(
        ContentLibrariesModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      totalItems: (json['total_items'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'per_page': instance.perPage,
      'total_items': instance.totalItems,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      title: json['title'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      plan: json['plan'] == null
          ? null
          : Plan.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'plan_id': instance.planId,
      'title': instance.title,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'plan': instance.plan,
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
