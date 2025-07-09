// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_tags_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterTagsModel _$FilterTagsModelFromJson(Map<String, dynamic> json) =>
    FilterTagsModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FilterTagsModelToJson(FilterTagsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'tags': instance.tags,
    };
