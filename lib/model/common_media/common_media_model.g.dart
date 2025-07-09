// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonMediaModel _$CommonMediaModelFromJson(Map<String, dynamic> json) =>
    CommonMediaModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommonMediaModelToJson(CommonMediaModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      mediaUrl: json['media_url'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'media_url': instance.mediaUrl,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
