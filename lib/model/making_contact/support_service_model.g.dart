// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportServiceModel _$SupportServiceModelFromJson(Map<String, dynamic> json) =>
    SupportServiceModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SupportServiceModelToJson(
        SupportServiceModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: (json['user_id'] as num?)?.toInt(),
      helpQuestion: json['help_question'] as String?,
      helpDetails: json['help_details'] as String?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'help_question': instance.helpQuestion,
      'help_details': instance.helpDetails,
      'updated_at': instance.updatedAt,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
