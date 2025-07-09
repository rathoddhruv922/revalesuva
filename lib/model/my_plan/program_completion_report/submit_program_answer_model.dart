// To parse this JSON data, do
//
//     final submitProgramAnswerModel = submitProgramAnswerModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'submit_program_answer_model.g.dart';

SubmitProgramAnswerModel submitProgramAnswerModelFromJson(String str) => SubmitProgramAnswerModel.fromJson(json.decode(str));

String submitProgramAnswerModelToJson(SubmitProgramAnswerModel data) => json.encode(data.toJson());

@JsonSerializable()
class SubmitProgramAnswerModel {
  @JsonKey(name: "answers")
  List<Answer>? answers;

  SubmitProgramAnswerModel({
    this.answers,
  });

  factory SubmitProgramAnswerModel.fromJson(Map<String, dynamic> json) => _$SubmitProgramAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitProgramAnswerModelToJson(this);
}

@JsonSerializable()
class Answer {
  @JsonKey(name: "plan_summary_report_id")
  int? planSummaryReportId;
  @JsonKey(name: "answer_type")
  String? answerType;
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "sub_answer")
  String? subAnswer;

  Answer({
    this.planSummaryReportId,
    this.answerType,
    this.answer,
    this.subAnswer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
