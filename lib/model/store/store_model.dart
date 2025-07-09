// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'store_model.g.dart';

StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
@JsonSerializable()
class StoreModel {
  @HiveField(1)
  @JsonKey(name: "status")
  int? status;
  @HiveField(3)
  @JsonKey(name: "message")
  String? message;
  @HiveField(5)
  @JsonKey(name: "data")
  Data? data;

  StoreModel({
    this.status,
    this.message,
    this.data,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Data {
  @HiveField(1)
  @JsonKey(name: "current_page")
  int? currentPage;
  @HiveField(3)
  @JsonKey(name: "total_pages")
  int? totalPages;
  @HiveField(5)
  @JsonKey(name: "per_page")
  int? perPage;
  @HiveField(7)
  @JsonKey(name: "total_items")
  int? totalItems;
  @HiveField(9)
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

@HiveType(typeId: 3)
@JsonSerializable()
class Datum {
  @HiveField(1)
  @JsonKey(name: "id")
  int? id;
  @HiveField(3)
  @JsonKey(name: "store_category_id")
  int? storeCategoryId;
  @HiveField(5)
  @JsonKey(name: "product_name")
  String? productName;
  @HiveField(7)
  @JsonKey(name: "image")
  String? image;
  @HiveField(9)
  @JsonKey(name: "description")
  String? description;
  @HiveField(11)
  @JsonKey(name: "price")
  String? price;
  @HiveField(13)
  @JsonKey(name: "quantity")
  int? quantity;
  @HiveField(15)
  @JsonKey(name: "recommended")
  bool? recommended;
  @HiveField(17)
  @JsonKey(name: "is_active")
  int? isActive;
  @HiveField(19)
  @JsonKey(name: "created_at")
  String? createdAt;
  @HiveField(21)
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @HiveField(23)
  @JsonKey(name: "favorite_users_count")
  int? favoriteUsersCount;
  @HiveField(25)
  @JsonKey(name: "favourite")
  bool? favourite;
  @HiveField(27)
  @JsonKey(name: "store_category")
  StoreCategory? storeCategory;
  @HiveField(29)
  @JsonKey(name: "qty")
  int? qty;

  Datum({
    this.id,
    this.storeCategoryId,
    this.productName,
    this.image,
    this.description,
    this.price,
    this.quantity,
    this.recommended,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.favoriteUsersCount,
    this.favourite,
    this.storeCategory,
    this.qty
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class StoreCategory {
  @HiveField(1)
  @JsonKey(name: "id")
  int? id;
  @HiveField(3)
  @JsonKey(name: "name")
  String? name;
  @HiveField(5)
  @JsonKey(name: "image")
  String? image;
  @HiveField(7)
  @JsonKey(name: "is_active")
  int? isActive;
  @HiveField(9)
  @JsonKey(name: "created_at")
  String? createdAt;
  @HiveField(11)
  @JsonKey(name: "updated_at")
  String? updatedAt;

  StoreCategory({
    this.id,
    this.name,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory StoreCategory.fromJson(Map<String, dynamic> json) => _$StoreCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoreCategoryToJson(this);
}
