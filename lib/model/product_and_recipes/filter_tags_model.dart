// To parse this JSON data, do
//
//     final filterTagsModel = filterTagsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'filter_tags_model.g.dart';

FilterTagsModel filterTagsModelFromJson(String str) => FilterTagsModel.fromJson(json.decode(str));

String filterTagsModelToJson(FilterTagsModel data) => json.encode(data.toJson());

@JsonSerializable()
class FilterTagsModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  FilterTagsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FilterTagsModel.fromJson(Map<String, dynamic> json) => _$FilterTagsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterTagsModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "tags")
  List<String>? tags;

  Data({
    this.tags,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
