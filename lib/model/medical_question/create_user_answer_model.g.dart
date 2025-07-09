// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserAnswerModel _$CreateUserAnswerModelFromJson(
        Map<String, dynamic> json) =>
    CreateUserAnswerModel(
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateUserAnswerModelToJson(
        CreateUserAnswerModel instance) =>
    <String, dynamic>{
      'answers': instance.answers,
    };

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      questionId: (json['question_id'] as num?)?.toInt(),
      answerType: json['answer_type'] as String?,
      answer: json['answer'] as String?,
      subAnswer: json['sub_answer'] as String?,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'question_id': instance.questionId,
      'answer_type': instance.answerType,
      'answer': instance.answer,
      'sub_answer': instance.subAnswer,
    };
