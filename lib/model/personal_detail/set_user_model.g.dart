// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetUserModel _$SetUserModelFromJson(Map<String, dynamic> json) => SetUserModel(
      name: json['name'] as String?,
      userName: json['user_name'] as String?,
      contactNumber: json['contact_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      height: json['height'] as String?,
      initialWeight: json['initial_weight'] as String?,
      gender: json['gender'] as String?,
      regularPeriod: json['regular_period'] as String?,
      dateOfLastPeriod: json['date_of_last_period'] as String?,
      street: json['street'] as String?,
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
      zipcode: json['zipcode'] as String?,
      city: json['city'] as String?,
      personalStatus: json['personal_status'] as String?,
      occupation: json['occupation'] as String?,
      chest: json['chest'] as String?,
      waist: json['waist'] as String?,
      hip: json['hip'] as String?,
      backPic: json['back_pic'] as String?,
      weight: json['weight'] as String?,
      sidePic: json['side_pic'] as String?,
      frontPic: json['front_pic'] as String?,
      profileImage: json['profile_image'] as String?,
      bloodTestReport: (json['blood_test_report'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      numberOfCycleDays: json['number_of_cycle_days'] as String?,
    );

Map<String, dynamic> _$SetUserModelToJson(SetUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'user_name': instance.userName,
      'contact_number': instance.contactNumber,
      'date_of_birth': instance.dateOfBirth,
      'height': instance.height,
      'initial_weight': instance.initialWeight,
      'weight': instance.weight,
      'gender': instance.gender,
      'regular_period': instance.regularPeriod,
      'date_of_last_period': instance.dateOfLastPeriod,
      'street': instance.street,
      'house': instance.house,
      'apartment': instance.apartment,
      'zipcode': instance.zipcode,
      'city': instance.city,
      'personal_status': instance.personalStatus,
      'occupation': instance.occupation,
      'chest': instance.chest,
      'waist': instance.waist,
      'hip': instance.hip,
      'back_pic': instance.backPic,
      'side_pic': instance.sidePic,
      'front_pic': instance.frontPic,
      'blood_test_report': instance.bloodTestReport,
      'profile_image': instance.profileImage,
      'number_of_cycle_days': instance.numberOfCycleDays,
    };
