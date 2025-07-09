// To parse this JSON data, do
//
//     final podcastHostsModel = podcastHostsModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'podcast_hosts_model.g.dart';

PodcastHostsModel podcastHostsModelFromJson(String str) => PodcastHostsModel.fromJson(json.decode(str));

String podcastHostsModelToJson(PodcastHostsModel data) => json.encode(data.toJson());

@JsonSerializable()
class PodcastHostsModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PodcastHostsModel({
    this.status,
    this.message,
    this.data,
  });

  factory PodcastHostsModel.fromJson(Map<String, dynamic> json) => _$PodcastHostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastHostsModelToJson(this);
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
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Datum({
    this.id,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
