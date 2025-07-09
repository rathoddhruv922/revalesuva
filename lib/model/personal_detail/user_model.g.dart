// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contact_number'] as String?,
      userName: json['user_name'] as String?,
      height: json['height'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      initialWeight: json['initial_weight'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      profileImage: json['profile_image'] as String?,
      regularPeriod: json['regular_period'] as String?,
      dateOfLastPeriod: json['date_of_last_period'] as String?,
      numberOfCycleDays: (json['number_of_cycle_days'] as num?)?.toInt(),
      street: json['street'] as String?,
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
      zipcode: json['zipcode'] as String?,
      city: json['city'] as String?,
      personalStatus: json['personal_status'] as String?,
      occupation: json['occupation'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      weights: (json['weights'] as List<dynamic>?)
          ?.map((e) => Weight.fromJson(e as Map<String, dynamic>))
          .toList(),
      circumferences: (json['circumferences'] as List<dynamic>?)
          ?.map((e) => Circumference.fromJson(e as Map<String, dynamic>))
          .toList(),
      bloodTests: (json['blood_tests'] as List<dynamic>?)
          ?.map((e) => BloodTest.fromJson(e as Map<String, dynamic>))
          .toList(),
      pictures: (json['pictures'] as List<dynamic>?)
          ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
          .toList(),
      plans: (json['plans'] as List<dynamic>?)
          ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
      programs: (json['programs'] as List<dynamic>?)
          ?.map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
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
      'gender': instance.gender,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'weights': instance.weights,
      'circumferences': instance.circumferences,
      'blood_tests': instance.bloodTests,
      'pictures': instance.pictures,
      'plans': instance.plans,
      'programs': instance.programs,
    };

Circumference _$CircumferenceFromJson(Map<String, dynamic> json) =>
    Circumference(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      chest: json['chest'] as String?,
      waist: json['waist'] as String?,
      hip: json['hip'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CircumferenceToJson(Circumference instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'chest': instance.chest,
      'waist': instance.waist,
      'hip': instance.hip,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      backPic: json['back_pic'] as String?,
      sidePic: json['side_pic'] as String?,
      frontPic: json['front_pic'] as String?,
      pictureType: json['picture_type'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'back_pic': instance.backPic,
      'side_pic': instance.sidePic,
      'front_pic': instance.frontPic,
      'picture_type': instance.pictureType,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Weight _$WeightFromJson(Map<String, dynamic> json) => Weight(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      weight: json['weight'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$WeightToJson(Weight instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'weight': instance.weight,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

BloodTest _$BloodTestFromJson(Map<String, dynamic> json) => BloodTest(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      bloodTestReport: json['blood_test_report'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      weight: json['weight'] as String?,
    );

Map<String, dynamic> _$BloodTestToJson(BloodTest instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'blood_test_report': instance.bloodTestReport,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'weight': instance.weight,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      startDatetime: json['start_datetime'] as String?,
      endDatetime: json['end_datetime'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_active': instance.isActive,
      'start_datetime': instance.startDatetime,
      'end_datetime': instance.endDatetime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
    };

Pivot _$PivotFromJson(Map<String, dynamic> json) => Pivot(
      userId: (json['user_id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      trainerId: (json['trainer_id'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PivotToJson(Pivot instance) => <String, dynamic>{
      'user_id': instance.userId,
      'plan_id': instance.planId,
      'trainer_id': instance.trainerId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      video: json['video'] as String?,
      vimeoVideoId: json['vimeo_video_id'] as String?,
      vimeoVideoHash: json['vimeo_video_hash'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      days: json['days'] as String?,
      repeat: (json['repeat'] as num?)?.toInt(),
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      pivot: json['pivot'] == null
          ? null
          : ProgramPivot.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'video': instance.video,
      'vimeo_video_id': instance.vimeoVideoId,
      'vimeo_video_hash': instance.vimeoVideoHash,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'days': instance.days,
      'repeat': instance.repeat,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'pivot': instance.pivot,
    };

ProgramPivot _$ProgramPivotFromJson(Map<String, dynamic> json) => ProgramPivot(
      userId: (json['user_id'] as num?)?.toInt(),
      programId: (json['program_id'] as num?)?.toInt(),
      scheduledId: (json['scheduled_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ProgramPivotToJson(ProgramPivot instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'program_id': instance.programId,
      'scheduled_id': instance.scheduledId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
