// To parse this JSON data, do
//
//     final afterBeforeImageModel = afterBeforeImageModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'after_before_image_model.g.dart';

AfterBeforeImageModel afterBeforeImageModelFromJson(String str) => AfterBeforeImageModel.fromJson(json.decode(str));

String afterBeforeImageModelToJson(AfterBeforeImageModel data) => json.encode(data.toJson());

@JsonSerializable()
class AfterBeforeImageModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  AfterBeforeImageModel({
    this.status,
    this.message,
    this.data,
  });

  factory AfterBeforeImageModel.fromJson(Map<String, dynamic> json) => _$AfterBeforeImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$AfterBeforeImageModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "after_photo")
  Photo? afterPhoto;
  @JsonKey(name: "before_photo")
  Photo? beforePhoto;

  Data({
    this.afterPhoto,
    this.beforePhoto,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Photo {
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

  Photo({
    this.id,
    this.userId,
    this.backPic,
    this.sidePic,
    this.frontPic,
    this.pictureType,
    this.createdAt,
    this.updatedAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
