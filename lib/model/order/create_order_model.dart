// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'create_order_model.g.dart';

CreateOrderModel createOrderModelFromJson(String str) => CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) => json.encode(data.toJson());

@JsonSerializable()
class CreateOrderModel {
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "order_status")
  String? orderStatus;
  @JsonKey(name: "sub_total")
  double? subTotal;
  @JsonKey(name: "grand_total")
  double? grandTotal;
  @JsonKey(name: "products")
  List<Product>? products;

  CreateOrderModel({
    this.date,
    this.orderStatus,
    this.subTotal,
    this.grandTotal,
    this.products,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) => _$CreateOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderModelToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "price")
  double? price;

  Product({
    this.productId,
    this.quantity,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
