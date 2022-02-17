// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ban_configuration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BanConfigurationAdapter extends TypeAdapter<BanConfiguration> {
  @override
  final int typeId = 1;

  @override
  BanConfiguration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BanConfiguration()
      ..isActivated = fields[0] == null ? false : fields[0] as bool
      ..champions = fields[1] == null
          ? {}
          : (fields[1] as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as Lane, (v as List).cast<ChampionModel>()));
  }

  @override
  void write(BinaryWriter writer, BanConfiguration obj) {
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
      other is BanConfigurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
