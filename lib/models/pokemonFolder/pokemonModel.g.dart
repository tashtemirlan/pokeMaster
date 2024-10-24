// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemonModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 1;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      pokeDexIndex: fields[0] as int,
      name: fields[1] as String,
      rarity: fields[2] as Rarity,
      type: (fields[3] as List).cast<PokeType>(),
      pokeStats: fields[4] as PokeStats,
      region: fields[5] as Region,
      weakness: (fields[6] as List).cast<PokeType?>(),
      gifFront: fields[7] as String,
      gifBack: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.pokeDexIndex)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.rarity)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.pokeStats)
      ..writeByte(5)
      ..write(obj.region)
      ..writeByte(6)
      ..write(obj.weakness)
      ..writeByte(7)
      ..write(obj.gifFront)
      ..writeByte(8)
      ..write(obj.gifBack);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
