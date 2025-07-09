// To parse this JSON data, do
//
//     final createFastingModel = createFastingModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_fasting_model.g.dart';

CreateFastingModel createFastingModelFromJson(String str) => CreateFastingModel.fromJson(json.decode(str));

String createFastingModelToJson(CreateFastingModel data) => json.encode(data.toJson());

@JsonSerializable()
class CreateFastingModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  CreateFastingModel({
    this.status,
    this.message,
    this.data,
  });

  factory CreateFastingModel.fromJson(Map<String, dynamic> json) => _$CreateFastingModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFastingModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "end_time")
  String? endTime;
  @JsonKey(name: "no_of_fasting_hours")
  int? noOfFastingHours;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "id")
  int? id;

  Data({
    this.userId,
    this.date,
    this.startTime,
    this.endTime,
    this.noOfFastingHours,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
