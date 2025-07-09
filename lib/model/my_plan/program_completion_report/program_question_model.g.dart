// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramQuestionModel _$ProgramQuestionModelFromJson(
        Map<String, dynamic> json) =>
    ProgramQuestionModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramQuestionModelToJson(
        ProgramQuestionModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      pageType: json['page_type'] as String?,
      question1: json['question1'] as String?,
      question2: json['question2'] as String?,
      answerType: json['answer_type'] as String?,
      order: (json['order'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      tempAns: json['tempAns'] as String?,
      tempAnsSub: json['tempAnsSub'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'page_type': instance.pageType,
      'question1': instance.question1,
      'question2': instance.question2,
      'answer_type': instance.answerType,
      'order': instance.order,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'tempAns': instance.tempAns,
      'tempAnsSub': instance.tempAnsSub,
    };
