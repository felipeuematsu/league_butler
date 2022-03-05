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
          fields[1] == null ? [] : (fields[1] as List).cast<FeatureType>()
      ..activatedRankedFeatures =
          fields[2] == null ? [] : (fields[2] as List).cast<FeatureType>()
      ..activatedCoopFeatures =
          fields[3] == null ? [] : (fields[3] as List).cast<FeatureType>()
      ..activatedCasualFeatures =
          fields[4] == null ? [] : (fields[4] as List).cast<FeatureType>()
      ..activatedOtherFeatures =
          fields[5] == null ? [] : (fields[5] as List).cast<FeatureType>();
  }

  @override
  void write(BinaryWriter writer, QueueConfiguration obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isActivated)
      ..writeByte(1)
      ..write(obj.activatedQueues)
      ..writeByte(2)
      ..write(obj.activatedRankedFeatures)
      ..writeByte(3)
      ..write(obj.activatedCoopFeatures)
      ..writeByte(4)
      ..write(obj.activatedCasualFeatures)
      ..writeByte(5)
      ..write(obj.activatedOtherFeatures);
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
