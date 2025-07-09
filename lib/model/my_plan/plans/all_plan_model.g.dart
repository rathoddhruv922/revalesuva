// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPlanModel _$AllPlanModelFromJson(Map<String, dynamic> json) => AllPlanModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPlanModelToJson(AllPlanModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      startDatetime: json['start_datetime'] as String?,
      endDatetime: json['end_datetime'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      trainer: json['trainer'] == null
          ? null
          : Trainer.fromJson(json['trainer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'trainer_id': instance.trainerId,
      'name': instance.name,
      'description': instance.description,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'is_active': instance.isActive,
      'start_datetime': instance.startDatetime,
      'end_datetime': instance.endDatetime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'trainer': instance.trainer,
    };

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'],
      temporaryPassword: json['temporary_password'],
      tempPwdCreatedAt: json['temp_pwd_created_at'],
      passwordChangeToken: json['password_change_token'],
      contactNumber: json['contact_number'],
      userName: json['user_name'],
      height: json['height'],
      isActive: (json['is_active'] as num?)?.toInt(),
      initialWeight: json['initial_weight'],
      dateOfBirth: json['date_of_birth'],
      profileImage: json['profile_image'],
      regularPeriod: json['regular_period'],
      dateOfLastPeriod: json['date_of_last_period'],
      numberOfCycleDays: json['number_of_cycle_days'],
      street: json['street'],
      house: json['house'],
      apartment: json['apartment'],
      zipcode: json['zipcode'],
      city: json['city'],
      personalStatus: json['personal_status'],
      occupation: json['occupation'],
      lastLogin: json['last_login'],
      gender: json['gender'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$TrainerToJson(Trainer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'temporary_password': instance.temporaryPassword,
      'temp_pwd_created_at': instance.tempPwdCreatedAt,
      'password_change_token': instance.passwordChangeToken,
      'contact_number': instance.contactNumber,
      'user_name': instance.userName,
      'height': instance.height,
      'is_active': instance.isActive,
      'initial_weight': instance.initialWeight,
      'date_of_birth': instance.dateOfBirth,
      'profile_image': instance.profileImage,
      'regular_period': instance.regularPeriod,
      'date_of_last_period': instance.dateOfLastPeriod,
      'number_of_cycle_days': instance.numberOfCycleDays,
      'street': instance.street,
      'house': instance.house,
      'apartment': instance.apartment,
      'zipcode': instance.zipcode,
      'city': instance.city,
      'personal_status': instance.personalStatus,
      'occupation': instance.occupation,
      'last_login': instance.lastLogin,
      'gender': instance.gender,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
