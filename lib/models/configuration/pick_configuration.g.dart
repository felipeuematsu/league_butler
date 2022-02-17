// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_configuration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PickConfigurationAdapter extends TypeAdapter<PickConfiguration> {
  @override
  final int typeId = 3;

  @override
  PickConfiguration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PickConfiguration()
      ..isActivated = fields[0] == null ? false : fields[0] as bool
      ..champions = fields[1] == null
          ? {}
          : (fields[1] as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as Lane, (v as List).cast<ChampionModel>()));
  }

  @override
  void write(BinaryWriter writer, PickConfiguration obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isActivated)
      ..writeByte(1)
      ..write(obj.champions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickConfigurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
