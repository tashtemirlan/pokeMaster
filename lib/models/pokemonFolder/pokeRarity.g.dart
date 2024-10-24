// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeRarity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RarityAdapter extends TypeAdapter<Rarity> {
  @override
  final int typeId = 4;

  @override
  Rarity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Rarity.casual;
      case 1:
        return Rarity.rare;
      case 2:
        return Rarity.epic;
      case 3:
        return Rarity.mystic;
      case 4:
        return Rarity.legendary;
      default:
        return Rarity.casual;
    }
  }

  @override
  void write(BinaryWriter writer, Rarity obj) {
    switch (obj) {
      case Rarity.casual:
        writer.writeByte(0);
        break;
      case Rarity.rare:
        writer.writeByte(1);
        break;
      case Rarity.epic:
        writer.writeByte(2);
        break;
      case Rarity.mystic:
        writer.writeByte(3);
        break;
      case Rarity.legendary:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RarityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
