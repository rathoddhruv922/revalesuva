// To parse this JSON data, do
//
//     final excludedDayModel = excludedDayModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'excluded_day_model.g.dart';

ExcludedDayModel excludedDayModelFromJson(String str) => ExcludedDayModel.fromJson(json.decode(str));

String excludedDayModelToJson(ExcludedDayModel data) => json.encode(data.toJson());

@JsonSerializable()
class ExcludedDayModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  ExcludedDayModel({
    this.status,
    this.message,
    this.data,
  });

  factory ExcludedDayModel.fromJson(Map<String, dynamic> json) => _$ExcludedDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExcludedDayModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "type")
  String? type;

  Datum({
    this.id,
    this.date,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.type
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
