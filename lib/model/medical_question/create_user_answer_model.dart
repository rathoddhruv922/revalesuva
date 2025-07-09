// To parse this JSON data, do
//
//     final createUserAnswerModel = createUserAnswerModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_user_answer_model.g.dart';

CreateUserAnswerModel createUserAnswerModelFromJson(String str) => CreateUserAnswerModel.fromJson(json.decode(str));

String createUserAnswerModelToJson(CreateUserAnswerModel data) => json.encode(data.toJson());

@JsonSerializable()
class CreateUserAnswerModel {
  @JsonKey(name: "answers")
  List<Answer>? answers;

  CreateUserAnswerModel({
    this.answers,
  });

  factory CreateUserAnswerModel.fromJson(Map<String, dynamic> json) => _$CreateUserAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserAnswerModelToJson(this);
}

@JsonSerializable()
class Answer {
  @JsonKey(name: "question_id")
  int? questionId;
  @JsonKey(name: "answer_type")
  String? answerType;
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "sub_answer")
  String? subAnswer;

  Answer({
    this.questionId,
    this.answerType,
    this.answer,
    this.subAnswer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
