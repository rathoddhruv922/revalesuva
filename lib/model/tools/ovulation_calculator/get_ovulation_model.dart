// To parse this JSON data, do
//
//     final getOvulationModel = getOvulationModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_ovulation_model.g.dart';

GetOvulationModel getOvulationModelFromJson(String str) => GetOvulationModel.fromJson(json.decode(str));

String getOvulationModelToJson(GetOvulationModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetOvulationModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  GetOvulationModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetOvulationModel.fromJson(Map<String, dynamic> json) => _$GetOvulationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetOvulationModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "created_at")
  dynamic createdAt;
  @JsonKey(name: "updated_at")
  dynamic updatedAt;

  Datum({
    this.id,
    this.userId,
    this.date,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
