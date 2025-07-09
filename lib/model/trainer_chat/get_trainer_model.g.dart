// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_trainer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTrainerModel _$GetTrainerModelFromJson(Map<String, dynamic> json) =>
    GetTrainerModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTrainerModelToJson(GetTrainerModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
      trainerPlans: (json['trainer_plans'] as List<dynamic>?)
          ?.map((e) => TrainerPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      trainerPrograms: (json['trainer_programs'] as List<dynamic>?)
          ?.map((e) => TrainerProgram.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'trainer_id': instance.trainerId,
      'name': instance.name,
      'email': instance.email,
      'contact_number': instance.contactNumber,
      'trainer_plans': instance.trainerPlans,
      'trainer_programs': instance.trainerPrograms,
    };

TrainerPlan _$TrainerPlanFromJson(Map<String, dynamic> json) => TrainerPlan(
      planId: (json['plan_id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TrainerPlanToJson(TrainerPlan instance) =>
    <String, dynamic>{
      'plan_id': instance.planId,
      'name': instance.name,
    };

TrainerProgram _$TrainerProgramFromJson(Map<String, dynamic> json) =>
    TrainerProgram(
      programId: (json['program_id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TrainerProgramToJson(TrainerProgram instance) =>
    <String, dynamic>{
      'program_id': instance.programId,
      'name': instance.name,
    };
