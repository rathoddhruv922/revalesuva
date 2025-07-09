// To parse this JSON data, do
//
//     final pastWorkshopEventModel = pastWorkshopEventModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'past_workshop_event_model.g.dart';

PastWorkshopEventModel pastWorkshopEventModelFromJson(String str) =>
    PastWorkshopEventModel.fromJson(json.decode(str));

String pastWorkshopEventModelToJson(PastWorkshopEventModel data) => json.encode(data.toJson());

@JsonSerializable()
class PastWorkshopEventModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PastWorkshopEventModel({
    this.status,
    this.message,
    this.data,
  });

  factory PastWorkshopEventModel.fromJson(Map<String, dynamic> json) =>
      _$PastWorkshopEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$PastWorkshopEventModelToJson(this);
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
  @JsonKey(name: "workshop_event_id")
  int? workshopEventId;
  @JsonKey(name: "participant_name")
  String? participantName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "house")
  String? house;
  @JsonKey(name: "apartment")
  String? apartment;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "zipcode")
  String? zipcode;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "work_shop_event")
  WorkShopEvent? workShopEvent;

  Datum({
    this.id,
    this.userId,
    this.workshopEventId,
    this.participantName,
    this.email,
    this.phoneNumber,
    this.street,
    this.house,
    this.apartment,
    this.city,
    this.zipcode,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.workShopEvent,
    this.date,
    this.time,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class WorkShopEvent {
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

  WorkShopEvent({
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

  factory WorkShopEvent.fromJson(Map<String, dynamic> json) => _$WorkShopEventFromJson(json);

  Map<String, dynamic> toJson() => _$WorkShopEventToJson(this);
}
