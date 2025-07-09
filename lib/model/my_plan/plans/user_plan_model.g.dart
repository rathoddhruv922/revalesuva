// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPlanModel _$UserPlanModelFromJson(Map<String, dynamic> json) =>
    UserPlanModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserPlanModelToJson(UserPlanModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      planCycleId: (json['plan_cycle_id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      plan: json['plan'] == null
          ? null
          : Plan.fromJson(json['plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'plan_id': instance.planId,
      'plan_cycle_id': instance.planCycleId,
      'trainer_id': instance.trainerId,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'plan': instance.plan,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: (json['id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      weekDays: json['week_days'] as String?,
      repeat: (json['repeat'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activeDay: json['active_day'] as String?,
      settings: json['settings'] == null
          ? null
          : Settings.fromJson(json['settings'] as Map<String, dynamic>),
      planCycles: (json['plan_cycles'] as List<dynamic>?)
          ?.map((e) => PlanCycle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'trainer_id': instance.trainerId,
      'name': instance.name,
      'description': instance.description,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'week_days': instance.weekDays,
      'repeat': instance.repeat,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'active_day': instance.activeDay,
      'settings': instance.settings,
      'plan_cycles': instance.planCycles,
    };

PlanCycle _$PlanCycleFromJson(Map<String, dynamic> json) => PlanCycle(
      id: (json['id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PlanCycleToJson(PlanCycle instance) => <String, dynamic>{
      'id': instance.id,
      'plan_id': instance.planId,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      vegetablesChallenge: json['vegetables_challenge'] == null
          ? null
          : DailyReport.fromJson(
              json['vegetables_challenge'] as Map<String, dynamic>),
      measurement: json['measurement'] == null
          ? null
          : DailyReport.fromJson(json['measurement'] as Map<String, dynamic>),
      weightModule: json['weight_module'] == null
          ? null
          : DailyReport.fromJson(json['weight_module'] as Map<String, dynamic>),
      fastingModule: json['fasting_module'] == null
          ? null
          : DailyReport.fromJson(
              json['fasting_module'] as Map<String, dynamic>),
      periodModule: json['period_module'] == null
          ? null
          : DailyReport.fromJson(json['period_module'] as Map<String, dynamic>),
      weeklyReport: json['weekly_report'] == null
          ? null
          : DailyReport.fromJson(json['weekly_report'] as Map<String, dynamic>),
      dailyReport: json['daily_report'] == null
          ? null
          : DailyReport.fromJson(json['daily_report'] as Map<String, dynamic>),
      lessonSummary: json['lesson_summary'] == null
          ? null
          : DailyReport.fromJson(
              json['lesson_summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'vegetables_challenge': instance.vegetablesChallenge,
      'measurement': instance.measurement,
      'weight_module': instance.weightModule,
      'fasting_module': instance.fastingModule,
      'period_module': instance.periodModule,
      'weekly_report': instance.weeklyReport,
      'daily_report': instance.dailyReport,
      'lesson_summary': instance.lessonSummary,
    };

DailyReport _$DailyReportFromJson(Map<String, dynamic> json) => DailyReport(
      day: json['day'] as String?,
    );

Map<String, dynamic> _$DailyReportToJson(DailyReport instance) =>
    <String, dynamic>{
      'day': instance.day,
    };
