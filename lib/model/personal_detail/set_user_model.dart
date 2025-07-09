// To parse this JSON data, do
//
//     final setUserModel = setUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'set_user_model.g.dart';

SetUserModel setUserModelFromJson(String str) => SetUserModel.fromJson(json.decode(str));

String setUserModelToJson(SetUserModel data) => json.encode(data.toJson());

@JsonSerializable()
class SetUserModel {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "user_name")
  String? userName;
  @JsonKey(name: "contact_number")
  String? contactNumber;
  @JsonKey(name: "date_of_birth")
  String? dateOfBirth;
  @JsonKey(name: "height")
  String? height;
  @JsonKey(name: "initial_weight")
  String? initialWeight;
  @JsonKey(name: "weight")
  String? weight;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "regular_period")
  String? regularPeriod;
  @JsonKey(name: "date_of_last_period")
  String? dateOfLastPeriod;
  @JsonKey(name: "street")
  String? street;
  @JsonKey(name: "house")
  String? house;
  @JsonKey(name: "apartment")
  String? apartment;
  @JsonKey(name: "zipcode")
  String? zipcode;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "personal_status")
  String? personalStatus;
  @JsonKey(name: "occupation")
  String? occupation;
  @JsonKey(name: "chest")
  String? chest;
  @JsonKey(name: "waist")
  String? waist;
  @JsonKey(name: "hip")
  String? hip;
  @JsonKey(name: "back_pic")
  String? backPic;
  @JsonKey(name: "side_pic")
  String? sidePic;
  @JsonKey(name: "front_pic")
  String? frontPic;
  @JsonKey(name: "blood_test_report")
  List<String>? bloodTestReport;
  @JsonKey(name: "profile_image")
  String? profileImage;
  @JsonKey(name: "number_of_cycle_days")
  String? numberOfCycleDays;

  SetUserModel(
      {this.name,
      this.userName,
      this.contactNumber,
      this.dateOfBirth,
      this.height,
      this.initialWeight,
      this.gender,
      this.regularPeriod,
      this.dateOfLastPeriod,
      this.street,
      this.house,
      this.apartment,
      this.zipcode,
      this.city,
      this.personalStatus,
      this.occupation,
      this.chest,
      this.waist,
      this.hip,
      this.backPic,
      this.weight,
      this.sidePic,
      this.frontPic,
      this.profileImage,
      this.bloodTestReport,
      this.numberOfCycleDays});

  factory SetUserModel.fromJson(Map<String, dynamic> json) => _$SetUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetUserModelToJson(this);
}
