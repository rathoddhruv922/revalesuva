// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stars_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarsModel _$StarsModelFromJson(Map<String, dynamic> json) => StarsModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StarsModelToJson(StarsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      stars: (json['stars'] as List<dynamic>?)
          ?.map((e) => Star.fromJson(e as Map<String, dynamic>))
          .toList(),
      getUserAchievements: (json['get_user_achievements'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'stars': instance.stars,
      'get_user_achievements': instance.getUserAchievements,
    };

Star _$StarFromJson(Map<String, dynamic> json) => Star(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$StarToJson(Star instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
