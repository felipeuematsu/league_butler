// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_champion_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BanConfigurationChampionModelAdapter
    extends TypeAdapter<BanConfigurationChampionModel> {
  @override
  final int typeId = 4;

  @override
  BanConfigurationChampionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BanConfigurationChampionModel()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..image = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, BanConfigurationChampionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BanConfigurationChampionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
