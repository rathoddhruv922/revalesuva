// To parse this JSON data, do
//
//     final userAnsModel = userAnsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'user_ans_model.g.dart';

UserAnsModel userAnsModelFromJson(String str) => UserAnsModel.fromJson(json.decode(str));

String userAnsModelToJson(UserAnsModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserAnsModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  UserAnsModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserAnsModel.fromJson(Map<String, dynamic> json) => _$UserAnsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAnsModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "question_id")
  int? questionId;
  @JsonKey(name: "answer_type")
  String? answerType;
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "sub_answer")
  dynamic subAnswer;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "question")
  Question? question;

  Datum({
    this.id,
    this.userId,
    this.questionId,
    this.answerType,
    this.answer,
    this.subAnswer,
    this.createdAt,
    this.updatedAt,
    this.question,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Question {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "question")
  String? question;
  @JsonKey(name: "answer_type")
  String? answerType;

  Question({
    this.id,
    this.question,
    this.answerType,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
