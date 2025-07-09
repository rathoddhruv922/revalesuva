// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'after_before_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AfterBeforeImageModel _$AfterBeforeImageModelFromJson(
        Map<String, dynamic> json) =>
    AfterBeforeImageModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AfterBeforeImageModelToJson(
        AfterBeforeImageModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      afterPhoto: json['after_photo'] == null
          ? null
          : Photo.fromJson(json['after_photo'] as Map<String, dynamic>),
      beforePhoto: json['before_photo'] == null
          ? null
          : Photo.fromJson(json['before_photo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'after_photo': instance.afterPhoto,
      'before_photo': instance.beforePhoto,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      backPic: json['back_pic'] as String?,
      sidePic: json['side_pic'] as String?,
      frontPic: json['front_pic'] as String?,
      pictureType: json['picture_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'back_pic': instance.backPic,
      'side_pic': instance.sidePic,
      'front_pic': instance.frontPic,
      'picture_type': instance.pictureType,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
