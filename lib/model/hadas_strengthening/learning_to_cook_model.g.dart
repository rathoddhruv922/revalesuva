// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_to_cook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningToCookModel _$LearningToCookModelFromJson(Map<String, dynamic> json) =>
    LearningToCookModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LearningToCookModelToJson(
        LearningToCookModel instance) =>
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
      title: json['title'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
