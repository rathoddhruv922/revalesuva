// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
@JsonSerializable()
class ProductModel {
  @HiveField(1)
  @JsonKey(name: "status")
  int? status;
  @HiveField(3)
  @JsonKey(name: "message")
  String? message;
  @HiveField(5)
  @JsonKey(name: "data")
  Data? data;

  ProductModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
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
  @JsonKey(name: "category_id")
  int? categoryId;
  @HiveField(5)
  @JsonKey(name: "name")
  String? name;
  @HiveField(7)
  @JsonKey(name: "image")
  String? image;
  @HiveField(9)
  @JsonKey(name: "recommended")
  int? recommended;
  @HiveField(11)
  @JsonKey(name: "is_active")
  int? isActive;
  @HiveField(13)
  @JsonKey(name: "created_at")
  String? createdAt;
  @HiveField(15)
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @HiveField(17)
  @JsonKey(name: "category")
  Category? category;
  @HiveField(19)
  int qty;

  Datum({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.recommended,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.qty = 0,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@HiveType(typeId: 4)
@JsonSerializable()
class Category {
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

  Category({
    this.id,
    this.name,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
