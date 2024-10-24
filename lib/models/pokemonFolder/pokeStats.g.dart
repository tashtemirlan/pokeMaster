// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeStats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokeStatsAdapter extends TypeAdapter<PokeStats> {
  @override
  final int typeId = 2;

  @override
  PokeStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokeStats(
      hp: fields[0] as double,
      attack: fields[1] as double,
      defence: fields[2] as double,
      specialAttack: fields[3] as double,
      specialDefence: fields[4] as double,
      speed: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PokeStats obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hp)
      ..writeByte(1)
      ..write(obj.attack)
      ..writeByte(2)
      ..write(obj.defence)
      ..writeByte(3)
      ..write(obj.specialAttack)
      ..writeByte(4)
      ..write(obj.specialDefence)
      ..writeByte(5)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokeStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
