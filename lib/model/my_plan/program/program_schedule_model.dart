// To parse this JSON data, do
//
//     final programScheduleModel = programScheduleModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'program_schedule_model.g.dart';

ProgramScheduleModel programScheduleModelFromJson(String str) => ProgramScheduleModel.fromJson(json.decode(str));

String programScheduleModelToJson(ProgramScheduleModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProgramScheduleModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  ProgramScheduleModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProgramScheduleModel.fromJson(Map<String, dynamic> json) => _$ProgramScheduleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramScheduleModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "instructor")
  String? instructor;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "total_capacity")
  int? totalCapacity;
  @JsonKey(name: "total_register")
  int? totalRegister;
  @JsonKey(name: "total_in_waiting")
  int? totalInWaiting;
  @JsonKey(name: "user")
  User? user;

  Datum({
    this.id,
    this.name,
    this.instructor,
    this.date,
    this.time,
    this.totalCapacity,
    this.totalRegister,
    this.totalInWaiting,
    this.user,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "status")
  String? status;

  User({
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
