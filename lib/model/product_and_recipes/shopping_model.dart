// To parse this JSON data, do
//
//     final shoppingModel = shoppingModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_model.g.dart';

ShoppingModel shoppingModelFromJson(String str) => ShoppingModel.fromJson(json.decode(str));

String shoppingModelToJson(ShoppingModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
@JsonSerializable()
class ShoppingModel extends HiveObject {
  @HiveField(1)
  @JsonKey(name: "id")
  String? id;
  @HiveField(3)
  @JsonKey(name: "name")
  String? name;
  @HiveField(5)
  @JsonKey(name: "image")
  String? image;
  @HiveField(7)
  @JsonKey(name: "qty")
  int? qty;
  @HiveField(9)
  @JsonKey(name: "type")
  String? type;
  @HiveField(11)
  @JsonKey(name: "isSelected")
  bool? isSelected;

  ShoppingModel({
    this.id,
    this.name,
    this.image,
    this.qty,
    this.type,
    this.isSelected,
  });

  factory ShoppingModel.fromJson(Map<String, dynamic> json) => _$ShoppingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingModelToJson(this);
}
