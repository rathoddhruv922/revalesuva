// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ans_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAnsModel _$UserAnsModelFromJson(Map<String, dynamic> json) => UserAnsModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserAnsModelToJson(UserAnsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      questionId: (json['question_id'] as num?)?.toInt(),
      answerType: json['answer_type'] as String?,
      answer: json['answer'] as String?,
      subAnswer: json['sub_answer'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      question: json['question'] == null
          ? null
          : Question.fromJson(json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'question_id': instance.questionId,
      'answer_type': instance.answerType,
      'answer': instance.answer,
      'sub_answer': instance.subAnswer,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'question': instance.question,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      answerType: json['answer_type'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer_type': instance.answerType,
    };
