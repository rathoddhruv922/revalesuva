// To parse this JSON data, do
//
//     final emptyModel = emptyModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'empty_model.g.dart';

EmptyModel emptyModelFromJson(String str) => EmptyModel.fromJson(json.decode(str));

String emptyModelToJson(EmptyModel data) => json.encode(data.toJson());

@JsonSerializable()
class EmptyModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "errors")
  dynamic errors;

  EmptyModel({
    this.status,
    this.message,
    this.errors,
  });

  factory EmptyModel.fromJson(Map<String, dynamic> json) => _$EmptyModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyModelToJson(this);
}

