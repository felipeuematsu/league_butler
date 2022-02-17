// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_configuration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QueueConfigurationAdapter extends TypeAdapter<QueueConfiguration> {
  @override
  final int typeId = 2;

  @override
  QueueConfiguration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QueueConfiguration()
      ..isActivated = fields[0] == null ? false : fields[0] as bool
      ..activatedQueues =
          fields[1] == null ? [] : (fields[1] as List).cast<int>()
      ..rankedActivated = fields[2] == null ? false : fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, QueueConfiguration obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isActivated)
      ..writeByte(1)
      ..write(obj.activatedQueues)
      ..writeByte(2)
      ..write(obj.rankedActivated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueueConfigurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
