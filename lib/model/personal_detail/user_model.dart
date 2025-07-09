// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@JsonSerializable()
class UserModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  UserModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "contact_number")
  String? contactNumber;
  @JsonKey(name: "user_name")
  String? userName;
  @JsonKey(name: "height")
  String? height;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "initial_weight")
  String? initialWeight;
  @JsonKey(name: "date_of_birth")
  String? dateOfBirth;
  @JsonKey(name: "profile_image")
  String? profileImage;
  @JsonKey(name: "regular_period")
  String? regularPeriod;
  @JsonKey(name: "date_of_last_period")
  String? dateOfLastPeriod;
  @JsonKey(name: "number_of_cycle_days")
  int? numberOfCycleDays;
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
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "weights")
  List<Weight>? weights;
  @JsonKey(name: "circumferences")
  List<Circumference>? circumferences;
  @JsonKey(name: "blood_tests")
  List<BloodTest>? bloodTests;
  @JsonKey(name: "pictures")
  List<Picture>? pictures;
  @JsonKey(name: "plans")
  List<Plan>? plans;
  @JsonKey(name: "programs")
  List<Program>? programs;

  Data({
    this.id,
    this.name,
    this.email,
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
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.weights,
    this.circumferences,
    this.bloodTests,
    this.pictures,
    this.plans,
    this.programs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Circumference {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "chest")
  String? chest;
  @JsonKey(name: "waist")
  String? waist;
  @JsonKey(name: "hip")
  String? hip;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Circumference({
    this.id,
    this.userId,
    this.chest,
    this.waist,
    this.hip,
    this.createdAt,
    this.updatedAt,
  });

  factory Circumference.fromJson(Map<String, dynamic> json) => _$CircumferenceFromJson(json);

  Map<String, dynamic> toJson() => _$CircumferenceToJson(this);
}

@JsonSerializable()
class Picture {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "back_pic")
  String? backPic;
  @JsonKey(name: "side_pic")
  String? sidePic;
  @JsonKey(name: "front_pic")
  String? frontPic;
  @JsonKey(name: "picture_type")
  String? pictureType;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Picture({
    this.id,
    this.userId,
    this.backPic,
    this.sidePic,
    this.frontPic,
    this.pictureType,
    this.createdAt,
    this.updatedAt,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => _$PictureFromJson(json);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}

@JsonSerializable()
class Weight {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "weight")
  String? weight;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Weight({
    this.id,
    this.userId,
    this.weight,
    this.createdAt,
    this.updatedAt,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);

  Map<String, dynamic> toJson() => _$WeightToJson(this);
}

@JsonSerializable()
class BloodTest {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "blood_test_report")
  String? bloodTestReport;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "weight")
  String? weight;

  BloodTest({
    this.id,
    this.userId,
    this.bloodTestReport,
    this.createdAt,
    this.updatedAt,
    this.weight,
  });

  factory BloodTest.fromJson(Map<String, dynamic> json) => _$BloodTestFromJson(json);

  Map<String, dynamic> toJson() => _$BloodTestToJson(this);
}

@JsonSerializable()
class Plan {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
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
  @JsonKey(name: "pivot")
  Pivot? pivot;

  Plan({
    this.id,
    this.name,
    this.description,
    this.isActive,
    this.startDatetime,
    this.endDatetime,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}

@JsonSerializable()
class Pivot {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "plan_id")
  int? planId;
  @JsonKey(name: "trainer_id")
  int? trainerId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Pivot({
    this.userId,
    this.planId,
    this.createdAt,
    this.trainerId,
    this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => _$PivotFromJson(json);

  Map<String, dynamic> toJson() => _$PivotToJson(this);
}

@JsonSerializable()
class Program {
  @JsonKey(name: "id")
  int? id;
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
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;
  @JsonKey(name: "days")
  String? days;
  @JsonKey(name: "repeat")
  int? repeat;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "pivot")
  ProgramPivot? pivot;

  Program({
    this.id,
    this.name,
    this.description,
    this.video,
    this.vimeoVideoId,
    this.vimeoVideoHash,
    this.startDate,
    this.endDate,
    this.days,
    this.repeat,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);
}

@JsonSerializable()
class ProgramPivot {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "program_id")
  int? programId;
  @JsonKey(name: "scheduled_id")
  int? scheduledId;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  ProgramPivot({
    this.userId,
    this.programId,
    this.scheduledId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramPivot.fromJson(Map<String, dynamic> json) => _$ProgramPivotFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramPivotToJson(this);
}
