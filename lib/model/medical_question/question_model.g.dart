// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      answerType: json['answer_type'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      type: json['type'] as String?,
      order: (json['order'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      mcqOptions: (json['mcq_options'] as List<dynamic>?)
          ?.map((e) => McqOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      day: (json['day'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer_type': instance.answerType,
      'is_active': instance.isActive,
      'type': instance.type,
      'day': instance.day,
      'order': instance.order,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'mcq_options': instance.mcqOptions,
    };

McqOption _$McqOptionFromJson(Map<String, dynamic> json) => McqOption(
      id: (json['id'] as num?)?.toInt(),
      questionId: (json['question_id'] as num?)?.toInt(),
      options: json['options'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$McqOptionToJson(McqOption instance) => <String, dynamic>{
      'id': instance.id,
      'question_id': instance.questionId,
      'options': instance.options,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
