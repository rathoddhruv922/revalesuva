// To parse this JSON data, do
//
//     final createWorkshopEventModel = createWorkshopEventModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'create_workshop_event_model.g.dart';

CreateWorkshopEventModel createWorkshopEventModelFromJson(String str) =>
    CreateWorkshopEventModel.fromJson(json.decode(str));

String createWorkshopEventModelToJson(CreateWorkshopEventModel data) => json.encode(data.toJson());

@JsonSerializable()
class CreateWorkshopEventModel {
  @JsonKey(name: "workshop_event_id")
  int? workshopEventId;
  @JsonKey(name: "user_workshop_event_id")
  int? userWorkshopEventId;
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
  double? price;

  CreateWorkshopEventModel({
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
    this.userWorkshopEventId,
  });

  factory CreateWorkshopEventModel.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkshopEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWorkshopEventModelToJson(this);
}
