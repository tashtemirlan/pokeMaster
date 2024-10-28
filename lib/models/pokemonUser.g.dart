// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemonUser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonUserAdapter extends TypeAdapter<PokemonUser> {
  @override
  final int typeId = 7;

  @override
  PokemonUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonUser(
      pokemon: fields[0] as Pokemon,
      lvl: fields[1] as int,
      hashId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonUser obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.pokemon)
      ..writeByte(1)
      ..write(obj.lvl)
      ..writeByte(2)
      ..write(obj.hashId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
