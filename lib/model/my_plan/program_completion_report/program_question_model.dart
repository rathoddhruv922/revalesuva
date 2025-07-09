// To parse this JSON data, do
//
//     final programQuestionModel = programQuestionModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'program_question_model.g.dart';

ProgramQuestionModel programQuestionModelFromJson(String str) =>
    ProgramQuestionModel.fromJson(json.decode(str));

String programQuestionModelToJson(ProgramQuestionModel data) => json.encode(data.toJson());

@JsonSerializable()
class ProgramQuestionModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  ProgramQuestionModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProgramQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$ProgramQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramQuestionModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "page_type")
  String? pageType;
  @JsonKey(name: "question1")
  String? question1;
  @JsonKey(name: "question2")
  String? question2;
  @JsonKey(name: "answer_type")
  String? answerType;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  String? tempAns;
  String? tempAnsSub;

  Datum(
      {this.id,
      this.pageType,
      this.question1,
      this.question2,
      this.answerType,
      this.order,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.tempAns,
      this.tempAnsSub});

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
