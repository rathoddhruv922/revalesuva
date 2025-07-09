// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'past_workshop_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PastWorkshopEventModel _$PastWorkshopEventModelFromJson(
        Map<String, dynamic> json) =>
    PastWorkshopEventModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PastWorkshopEventModelToJson(
        PastWorkshopEventModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      totalItems: (json['total_items'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'per_page': instance.perPage,
      'total_items': instance.totalItems,
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      workshopEventId: (json['workshop_event_id'] as num?)?.toInt(),
      participantName: json['participant_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      street: json['street'] as String?,
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      price: json['price'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      workShopEvent: json['work_shop_event'] == null
          ? null
          : WorkShopEvent.fromJson(
              json['work_shop_event'] as Map<String, dynamic>),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'workshop_event_id': instance.workshopEventId,
      'participant_name': instance.participantName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'street': instance.street,
      'house': instance.house,
      'apartment': instance.apartment,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'price': instance.price,
      'date': instance.date?.toIso8601String(),
      'time': instance.time,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'work_shop_event': instance.workShopEvent,
    };

WorkShopEvent _$WorkShopEventFromJson(Map<String, dynamic> json) =>
    WorkShopEvent(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      noOfPeople: (json['no_of_people'] as num?)?.toInt(),
      image: json['image'] as String?,
      price: json['price'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$WorkShopEventToJson(WorkShopEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'no_of_people': instance.noOfPeople,
      'image': instance.image,
      'price': instance.price,
      'date': instance.date?.toIso8601String(),
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
