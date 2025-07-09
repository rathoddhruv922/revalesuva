// To parse this JSON data, do
//
//     final futureWorkshopEventModel = futureWorkshopEventModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'future_workshop_event_model.g.dart';

FutureWorkshopEventModel futureWorkshopEventModelFromJson(String str) => FutureWorkshopEventModel.fromJson(json.decode(str));

String futureWorkshopEventModelToJson(FutureWorkshopEventModel data) => json.encode(data.toJson());

@JsonSerializable()
class FutureWorkshopEventModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  FutureWorkshopEventModel({
    this.status,
    this.message,
    this.data,
  });

  factory FutureWorkshopEventModel.fromJson(Map<String, dynamic> json) => _$FutureWorkshopEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$FutureWorkshopEventModelToJson(this);
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
  dynamic price;
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
  dynamic price;
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
