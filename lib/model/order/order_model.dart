// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'order_model.g.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "data")
  List<Datum>? data;

  OrderModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "order_number")
  String? orderNumber;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "date")
  DateTime? date;
  @JsonKey(name: "order_status")
  String? orderStatus;
  @JsonKey(name: "sub_total")
  dynamic subTotal;
  @JsonKey(name: "grand_total")
  dynamic grandTotal;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "order_details")
  List<OrderDetail>? orderDetails;

  Datum({
    this.id,
    this.orderNumber,
    this.userId,
    this.date,
    this.orderStatus,
    this.subTotal,
    this.grandTotal,
    this.createdAt,
    this.updatedAt,
    this.orderDetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class OrderDetail {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "order_id")
  int? orderId;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "product")
  Product? product;

  OrderDetail({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "store_category_id")
  int? storeCategoryId;
  @JsonKey(name: "product_name")
  String? productName;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "recommended")
  bool? recommended;
  @JsonKey(name: "is_active")
  int? isActive;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  Product({
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
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
