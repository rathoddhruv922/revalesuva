// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_user_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramUserSummaryModel _$ProgramUserSummaryModelFromJson(
        Map<String, dynamic> json) =>
    ProgramUserSummaryModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramUserSummaryModelToJson(
        ProgramUserSummaryModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      planSummaryReportId: (json['plan_summary_report_id'] as num?)?.toInt(),
      pageType: json['page_type'],
      answer: json['answer'] as String?,
      subAnswer: json['sub_answer'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      planSummaryReport: json['plan_summary_report'] == null
          ? null
          : PlanSummaryReport.fromJson(
              json['plan_summary_report'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'plan_summary_report_id': instance.planSummaryReportId,
      'page_type': instance.pageType,
      'answer': instance.answer,
      'sub_answer': instance.subAnswer,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'plan_summary_report': instance.planSummaryReport,
    };

PlanSummaryReport _$PlanSummaryReportFromJson(Map<String, dynamic> json) =>
    PlanSummaryReport(
      id: (json['id'] as num?)?.toInt(),
      pageType: json['page_type'] as String?,
      question1: json['question1'] as String?,
      question2: json['question2'] as String?,
      answerType: json['answer_type'] as String?,
      order: (json['order'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PlanSummaryReportToJson(PlanSummaryReport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page_type': instance.pageType,
      'question1': instance.question1,
      'question2': instance.question2,
      'answer_type': instance.answerType,
      'order': instance.order,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
