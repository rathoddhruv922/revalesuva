// To parse this JSON data, do
//
//     final podcastModel = podcastModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'podcast_model.g.dart';

PodcastModel podcastModelFromJson(String str) => PodcastModel.fromJson(json.decode(str));

String podcastModelToJson(PodcastModel data) => json.encode(data.toJson());

@JsonSerializable()
class PodcastModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  Data? data;

  PodcastModel({
    this.status,
    this.message,
    this.data,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) => _$PodcastModelFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastModelToJson(this);
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
  @JsonKey(name: "host_id")
  int? hostId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "audioupload")
  String? audioupload;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "podcasthost")
  Podcasthost? podcasthost;

  Datum({
    this.id,
    this.hostId,
    this.title,
    this.description,
    this.audioupload,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.podcasthost,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Podcasthost {
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

  Podcasthost({
    this.id,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Podcasthost.fromJson(Map<String, dynamic> json) => _$PodcasthostFromJson(json);

  Map<String, dynamic> toJson() => _$PodcasthostToJson(this);
}
