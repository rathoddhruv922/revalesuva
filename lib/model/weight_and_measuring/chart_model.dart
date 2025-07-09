// To parse this JSON data, do
//
//     final chartModel = chartModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'chart_model.g.dart';

List<ChartModel> chartModelFromJson(String str) => List<ChartModel>.from(json.decode(str).map((x) => ChartModel.fromJson(x)));

String chartModelToJson(List<ChartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ChartModel {
  @JsonKey(name: "date")
  String? date;
  @JsonKey(name: "value")
  double? value;

  ChartModel({
    this.date,
    this.value,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => _$ChartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChartModelToJson(this);
}
