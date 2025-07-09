// To parse this JSON data, do
//
//     final getSupportServiceModel = getSupportServiceModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'get_support_service_model.g.dart';

GetSupportServiceModel getSupportServiceModelFromJson(String str) => GetSupportServiceModel.fromJson(json.decode(str));

String getSupportServiceModelToJson(GetSupportServiceModel data) => json.encode(data.toJson());

@JsonSerializable()
class GetSupportServiceModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  GetSupportServiceModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetSupportServiceModel.fromJson(Map<String, dynamic> json) => _$GetSupportServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetSupportServiceModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "total_pages")
  int? totalPages;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "total_items")
  int? totalItems;
  @JsonKey(name: "data")
  List<Datum>? data;

  Data({
    this.currentPage,
    this.totalPages,
    this.perPage,
    this.totalItems,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "help_question")
  String? helpQuestion;
  @JsonKey(name: "help_details")
  String? helpDetails;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.helpQuestion,
    this.helpDetails,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
