// To parse this JSON data, do
//
//     final workshopEventModel = workshopEventModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'workshop_event_model.g.dart';

WorkshopEventModel workshopEventModelFromJson(String str) => WorkshopEventModel.fromJson(json.decode(str));

String workshopEventModelToJson(WorkshopEventModel data) => json.encode(data.toJson());

@JsonSerializable()
class WorkshopEventModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  WorkshopEventModel({
    this.status,
    this.message,
    this.data,
  });

  factory WorkshopEventModel.fromJson(Map<String, dynamic> json) => _$WorkshopEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkshopEventModelToJson(this);
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
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "no_of_people")
  int? noOfPeople;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "start_time")
  String? startTime;
  @JsonKey(name: "end_time")
  String? endTime;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.title,
    this.description,
    this.noOfPeople,
    this.image,
    this.price,
    this.date,
    this.startTime,
    this.endTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
