// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_username_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUsernameModel _$CheckUsernameModelFromJson(Map<String, dynamic> json) =>
    CheckUsernameModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CheckUsernameModelToJson(CheckUsernameModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
