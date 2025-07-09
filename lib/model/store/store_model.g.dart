// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreModelAdapter extends TypeAdapter<StoreModel> {
  @override
  final int typeId = 1;

  @override
  StoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreModel(
      status: fields[1] as int?,
      message: fields[3] as String?,
      data: fields[5] as Data?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataAdapter extends TypeAdapter<Data> {
  @override
  final int typeId = 2;

  @override
  Data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Data(
      currentPage: fields[1] as int?,
      totalPages: fields[3] as int?,
      perPage: fields[5] as int?,
      totalItems: fields[7] as int?,
      data: (fields[9] as List?)?.cast<Datum>(),
    );
  }

  @override
  void write(BinaryWriter writer, Data obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.currentPage)
      ..writeByte(3)
      ..write(obj.totalPages)
      ..writeByte(5)
      ..write(obj.perPage)
      ..writeByte(7)
      ..write(obj.totalItems)
      ..writeByte(9)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DatumAdapter extends TypeAdapter<Datum> {
  @override
  final int typeId = 3;

  @override
  Datum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datum(
      id: fields[1] as int?,
      storeCategoryId: fields[3] as int?,
      productName: fields[5] as String?,
      image: fields[7] as String?,
      description: fields[9] as String?,
      price: fields[11] as String?,
      quantity: fields[13] as int?,
      recommended: fields[15] as bool?,
      isActive: fields[17] as int?,
      createdAt: fields[19] as String?,
      updatedAt: fields[21] as String?,
      favoriteUsersCount: fields[23] as int?,
      favourite: fields[25] as bool?,
      storeCategory: fields[27] as StoreCategory?,
      qty: fields[29] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Datum obj) {
    writer
      ..writeByte(15)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.storeCategoryId)
      ..writeByte(5)
      ..write(obj.productName)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(11)
      ..write(obj.price)
      ..writeByte(13)
      ..write(obj.quantity)
      ..writeByte(15)
      ..write(obj.recommended)
      ..writeByte(17)
      ..write(obj.isActive)
      ..writeByte(19)
      ..write(obj.createdAt)
      ..writeByte(21)
      ..write(obj.updatedAt)
      ..writeByte(23)
      ..write(obj.favoriteUsersCount)
      ..writeByte(25)
      ..write(obj.favourite)
      ..writeByte(27)
      ..write(obj.storeCategory)
      ..writeByte(29)
      ..write(obj.qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StoreCategoryAdapter extends TypeAdapter<StoreCategory> {
  @override
  final int typeId = 4;

  @override
  StoreCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreCategory(
      id: fields[1] as int?,
      name: fields[3] as String?,
      image: fields[5] as String?,
      isActive: fields[7] as int?,
      createdAt: fields[9] as String?,
      updatedAt: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoreCategory obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
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
      storeCategoryId: (json['store_category_id'] as num?)?.toInt(),
      productName: json['product_name'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      recommended: json['recommended'] as bool?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      favoriteUsersCount: (json['favorite_users_count'] as num?)?.toInt(),
      favourite: json['favourite'] as bool?,
      storeCategory: json['store_category'] == null
          ? null
          : StoreCategory.fromJson(
              json['store_category'] as Map<String, dynamic>),
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'store_category_id': instance.storeCategoryId,
      'product_name': instance.productName,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'recommended': instance.recommended,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'favorite_users_count': instance.favoriteUsersCount,
      'favourite': instance.favourite,
      'store_category': instance.storeCategory,
      'qty': instance.qty,
    };

StoreCategory _$StoreCategoryFromJson(Map<String, dynamic> json) =>
    StoreCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      isActive: (json['is_active'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$StoreCategoryToJson(StoreCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
