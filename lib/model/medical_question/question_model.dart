// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

@JsonSerializable()
class QuestionModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  QuestionModel({
    this.status,
    this.message,
    this.data,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "question")
  String? question;
  @JsonKey(name: "answer_type")
  String? answerType;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "day")
  int? day;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "mcq_options")
  List<McqOption>? mcqOptions;

  Datum({
    this.id,
    this.question,
    this.answerType,
    this.isActive,
    this.type,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.mcqOptions,
    this.day,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class McqOption {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "question_id")
  int? questionId;
  @JsonKey(name: "options")
  String? options;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  McqOption({
    this.id,
    this.questionId,
    this.options,
    this.createdAt,
    this.updatedAt,
  });

  factory McqOption.fromJson(Map<String, dynamic> json) => _$McqOptionFromJson(json);

  Map<String, dynamic> toJson() => _$McqOptionToJson(this);
}
