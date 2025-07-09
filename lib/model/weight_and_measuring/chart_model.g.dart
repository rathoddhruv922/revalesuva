// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChartModel _$ChartModelFromJson(Map<String, dynamic> json) => ChartModel(
      date: json['date'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ChartModelToJson(ChartModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'value': instance.value,
    };
