// To parse this JSON data, do
//
//     final getTrainerModel = getTrainerModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_trainer_model.g.dart';

GetTrainerModel getTrainerModelFromJson(String str) => GetTrainerModel.fromJson(json.decode(str));

String getTrainerModelToJson(GetTrainerModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetTrainerModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  GetTrainerModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetTrainerModel.fromJson(Map<String, dynamic> json) => _$GetTrainerModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetTrainerModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "contact_number")
  String? contactNumber;
  @JsonKey(name: "trainer_plans")
  List<TrainerPlan>? trainerPlans;
  @JsonKey(name: "trainer_programs")
  List<TrainerProgram>? trainerPrograms;

  Datum({
    this.trainerId,
    this.name,
    this.email,
    this.contactNumber,
    this.trainerPlans,
    this.trainerPrograms,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class TrainerPlan {
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "name")
  String? name;

  TrainerPlan({
    this.planId,
    this.name,
  });

  factory TrainerPlan.fromJson(Map<String, dynamic> json) => _$TrainerPlanFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerPlanToJson(this);
}

@JsonSerializable()
class TrainerProgram {
  @JsonKey(name: "program_id")
  int? programId;
  @JsonKey(name: "name")
  String? name;

  TrainerProgram({
    this.programId,
    this.name,
  });

  factory TrainerProgram.fromJson(Map<String, dynamic> json) => _$TrainerProgramFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerProgramToJson(this);
}
