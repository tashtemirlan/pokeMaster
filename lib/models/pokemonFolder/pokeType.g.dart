// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokeTypeAdapter extends TypeAdapter<PokeType> {
  @override
  final int typeId = 5;

  @override
  PokeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PokeType.Normal;
      case 1:
        return PokeType.Fire;
      case 2:
        return PokeType.Water;
      case 3:
        return PokeType.Electric;
      case 4:
        return PokeType.Grass;
      case 5:
        return PokeType.Ice;
      case 6:
        return PokeType.Fighting;
      case 7:
        return PokeType.Poison;
      case 8:
        return PokeType.Ground;
      case 9:
        return PokeType.Flying;
      case 10:
        return PokeType.Psychic;
      case 11:
        return PokeType.Bug;
      case 12:
        return PokeType.Rock;
      case 13:
        return PokeType.Ghost;
      case 14:
        return PokeType.Dragon;
      case 15:
        return PokeType.Dark;
      case 16:
        return PokeType.Steel;
      case 17:
        return PokeType.Fairy;
      default:
        return PokeType.Normal;
    }
  }

  @override
  void write(BinaryWriter writer, PokeType obj) {
    switch (obj) {
      case PokeType.Normal:
        writer.writeByte(0);
        break;
      case PokeType.Fire:
        writer.writeByte(1);
        break;
      case PokeType.Water:
        writer.writeByte(2);
        break;
      case PokeType.Electric:
        writer.writeByte(3);
        break;
      case PokeType.Grass:
        writer.writeByte(4);
        break;
      case PokeType.Ice:
        writer.writeByte(5);
        break;
      case PokeType.Fighting:
        writer.writeByte(6);
        break;
      case PokeType.Poison:
        writer.writeByte(7);
        break;
      case PokeType.Ground:
        writer.writeByte(8);
        break;
      case PokeType.Flying:
        writer.writeByte(9);
        break;
      case PokeType.Psychic:
        writer.writeByte(10);
        break;
      case PokeType.Bug:
        writer.writeByte(11);
        break;
      case PokeType.Rock:
        writer.writeByte(12);
        break;
      case PokeType.Ghost:
        writer.writeByte(13);
        break;
      case PokeType.Dragon:
        writer.writeByte(14);
        break;
      case PokeType.Dark:
        writer.writeByte(15);
        break;
      case PokeType.Steel:
        writer.writeByte(16);
        break;
      case PokeType.Fairy:
        writer.writeByte(17);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
