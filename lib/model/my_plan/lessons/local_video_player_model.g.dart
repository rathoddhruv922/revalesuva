// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_video_player_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalVideoPlayerModelAdapter extends TypeAdapter<LocalVideoPlayerModel> {
  @override
  final int typeId = 8;

  @override
  LocalVideoPlayerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalVideoPlayerModel(
      id: fields[1] as String?,
      videoUrl: fields[3] as String?,
      totalLength: fields[5] as String?,
      playedLength: fields[7] as String?,
      status: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalVideoPlayerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.videoUrl)
      ..writeByte(5)
      ..write(obj.totalLength)
      ..writeByte(7)
      ..write(obj.playedLength)
      ..writeByte(9)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalVideoPlayerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalVideoPlayerModel _$LocalVideoPlayerModelFromJson(
        Map<String, dynamic> json) =>
    LocalVideoPlayerModel(
      id: json['id'] as String?,
      videoUrl: json['video_url'] as String?,
      totalLength: json['total_length'] as String?,
      playedLength: json['played_length'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$LocalVideoPlayerModelToJson(
        LocalVideoPlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'video_url': instance.videoUrl,
      'total_length': instance.totalLength,
      'played_length': instance.playedLength,
      'status': instance.status,
    };
