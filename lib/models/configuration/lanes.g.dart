// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lanes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaneAdapter extends TypeAdapter<Lane> {
  @override
  final int typeId = 5;

  @override
  Lane read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Lane.top;
      case 1:
        return Lane.mid;
      case 2:
        return Lane.bot;
      case 3:
        return Lane.jungle;
      case 4:
        return Lane.support;
      case 5:
        return Lane.otherOrAny;
      default:
        return Lane.otherOrAny;
    }
  }

  @override
  void write(BinaryWriter writer, Lane obj) {
    switch (obj) {
      case Lane.top:
        writer.writeByte(0);
        break;
      case Lane.mid:
        writer.writeByte(1);
        break;
      case Lane.bot:
        writer.writeByte(2);
        break;
      case Lane.jungle:
        writer.writeByte(3);
        break;
      case Lane.support:
        writer.writeByte(4);
        break;
      case Lane.otherOrAny:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
