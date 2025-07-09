// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmptyModel _$EmptyModelFromJson(Map<String, dynamic> json) => EmptyModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$EmptyModelToJson(EmptyModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
