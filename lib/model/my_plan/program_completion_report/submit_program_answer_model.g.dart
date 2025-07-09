// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_program_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitProgramAnswerModel _$SubmitProgramAnswerModelFromJson(
        Map<String, dynamic> json) =>
    SubmitProgramAnswerModel(
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitProgramAnswerModelToJson(
        SubmitProgramAnswerModel instance) =>
    <String, dynamic>{
      'answers': instance.answers,
    };

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      planSummaryReportId: (json['plan_summary_report_id'] as num?)?.toInt(),
      answerType: json['answer_type'] as String?,
      answer: json['answer'] as String?,
      subAnswer: json['sub_answer'] as String?,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'plan_summary_report_id': instance.planSummaryReportId,
      'answer_type': instance.answerType,
      'answer': instance.answer,
      'sub_answer': instance.subAnswer,
    };
