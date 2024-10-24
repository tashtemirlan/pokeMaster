// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeRegion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegionAdapter extends TypeAdapter<Region> {
  @override
  final int typeId = 3;

  @override
  Region read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Region.Kanto;
      case 1:
        return Region.Johto;
      case 2:
        return Region.Hoenn;
      case 3:
        return Region.Sinnoh;
      case 4:
        return Region.Unova;
      case 5:
        return Region.Kalos;
      default:
        return Region.Kanto;
    }
  }

  @override
  void write(BinaryWriter writer, Region obj) {
    switch (obj) {
      case Region.Kanto:
        writer.writeByte(0);
        break;
      case Region.Johto:
        writer.writeByte(1);
        break;
      case Region.Hoenn:
        writer.writeByte(2);
        break;
      case Region.Sinnoh:
        writer.writeByte(3);
        break;
      case Region.Unova:
        writer.writeByte(4);
        break;
      case Region.Kalos:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
