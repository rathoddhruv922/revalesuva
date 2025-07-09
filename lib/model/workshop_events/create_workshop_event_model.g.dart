// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_workshop_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWorkshopEventModel _$CreateWorkshopEventModelFromJson(
        Map<String, dynamic> json) =>
    CreateWorkshopEventModel(
      workshopEventId: (json['workshop_event_id'] as num?)?.toInt(),
      participantName: json['participant_name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      street: json['street'] as String?,
      house: json['house'] as String?,
      apartment: json['apartment'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      userWorkshopEventId: (json['user_workshop_event_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateWorkshopEventModelToJson(
        CreateWorkshopEventModel instance) =>
    <String, dynamic>{
      'workshop_event_id': instance.workshopEventId,
      'user_workshop_event_id': instance.userWorkshopEventId,
      'participant_name': instance.participantName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'street': instance.street,
      'house': instance.house,
      'apartment': instance.apartment,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'price': instance.price,
    };
