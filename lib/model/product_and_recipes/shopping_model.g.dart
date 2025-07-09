// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoppingModelAdapter extends TypeAdapter<ShoppingModel> {
  @override
  final int typeId = 1;

  @override
  ShoppingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShoppingModel(
      id: fields[1] as String?,
      name: fields[3] as String?,
      image: fields[5] as String?,
      qty: fields[7] as int?,
      type: fields[9] as String?,
      isSelected: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ShoppingModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.qty)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(11)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingModel _$ShoppingModelFromJson(Map<String, dynamic> json) =>
    ShoppingModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      type: json['type'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$ShoppingModelToJson(ShoppingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'qty': instance.qty,
      'type': instance.type,
      'isSelected': instance.isSelected,
    };
