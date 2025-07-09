// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramScheduleModel _$ProgramScheduleModelFromJson(
        Map<String, dynamic> json) =>
    ProgramScheduleModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramScheduleModelToJson(
        ProgramScheduleModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      instructor: json['instructor'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
      totalCapacity: (json['total_capacity'] as num?)?.toInt(),
      totalRegister: (json['total_register'] as num?)?.toInt(),
      totalInWaiting: (json['total_in_waiting'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'instructor': instance.instructor,
      'date': instance.date?.toIso8601String(),
      'time': instance.time,
      'total_capacity': instance.totalCapacity,
      'total_register': instance.totalRegister,
      'total_in_waiting': instance.totalInWaiting,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'status': instance.status,
    };
