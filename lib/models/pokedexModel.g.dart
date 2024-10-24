// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedexModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokedexPokemonModelAdapter extends TypeAdapter<PokedexPokemonModel> {
  @override
  final int typeId = 0;

  @override
  PokedexPokemonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokedexPokemonModel(
      pokemon: fields[0] as Pokemon,
      isFound: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PokedexPokemonModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pokemon)
      ..writeByte(1)
      ..write(obj.isFound);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokedexPokemonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
