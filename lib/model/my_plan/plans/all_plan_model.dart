// To parse this JSON data, do
//
//     final allPlanModel = allPlanModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'all_plan_model.g.dart';

AllPlanModel allPlanModelFromJson(String str) => AllPlanModel.fromJson(json.decode(str));

String allPlanModelToJson(AllPlanModel data) => json.encode(data.toJson());

@JsonSerializable()
class AllPlanModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  AllPlanModel({
    this.status,
    this.message,
    this.data,
  });

  factory AllPlanModel.fromJson(Map<String, dynamic> json) => _$AllPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllPlanModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "video")
  String? video;
  @JsonKey(name: "vimeo_video_id")
  String? vimeoVideoId;
  @JsonKey(name: "vimeo_video_hash")
  String? vimeoVideoHash;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "start_datetime")
  String? startDatetime;
  @JsonKey(name: "end_datetime")
  String? endDatetime;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "trainer")
  Trainer? trainer;

  Datum({
    this.id,
    this.trainerId,
    this.name,
    this.description,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.isActive,
    this.startDatetime,
    this.endDatetime,
    this.createdAt,
    this.updatedAt,
    this.trainer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Trainer {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "email_verified_at")
  dynamic emailVerifiedAt;
  @JsonKey(name: "temporary_password")
  dynamic temporaryPassword;
  @JsonKey(name: "temp_pwd_created_at")
  dynamic tempPwdCreatedAt;
  @JsonKey(name: "password_change_token")
  dynamic passwordChangeToken;
  @JsonKey(name: "contact_number")
  dynamic contactNumber;
  @JsonKey(name: "user_name")
  dynamic userName;
  @JsonKey(name: "height")
  dynamic height;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "initial_weight")
  dynamic initialWeight;
  @JsonKey(name: "date_of_birth")
  dynamic dateOfBirth;
  @JsonKey(name: "profile_image")
  dynamic profileImage;
  @JsonKey(name: "regular_period")
  dynamic regularPeriod;
  @JsonKey(name: "date_of_last_period")
  dynamic dateOfLastPeriod;
  @JsonKey(name: "number_of_cycle_days")
  dynamic numberOfCycleDays;
  @JsonKey(name: "street")
  dynamic street;
  @JsonKey(name: "house")
  dynamic house;
  @JsonKey(name: "apartment")
  dynamic apartment;
  @JsonKey(name: "zipcode")
  dynamic zipcode;
  @JsonKey(name: "city")
  dynamic city;
  @JsonKey(name: "personal_status")
  dynamic personalStatus;
  @JsonKey(name: "occupation")
  dynamic occupation;
  @JsonKey(name: "last_login")
  dynamic lastLogin;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Trainer({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.temporaryPassword,
    this.tempPwdCreatedAt,
    this.passwordChangeToken,
    this.contactNumber,
    this.userName,
    this.height,
    this.isActive,
    this.initialWeight,
    this.dateOfBirth,
    this.profileImage,
    this.regularPeriod,
    this.dateOfLastPeriod,
    this.numberOfCycleDays,
    this.street,
    this.house,
    this.apartment,
    this.zipcode,
    this.city,
    this.personalStatus,
    this.occupation,
    this.lastLogin,
    this.gender,
    this.createdAt,
    this.updatedAt,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => _$TrainerFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}
