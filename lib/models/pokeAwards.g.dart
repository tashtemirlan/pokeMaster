// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeAwards.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokeAwardsAdapter extends TypeAdapter<PokeAwards> {
  @override
  final int typeId = 6;

  @override
  PokeAwards read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokeAwards(
      awardImagePath: fields[0] as String,
      obtained: fields[1] as bool,
      awardName: fields[2] as String,
      cityName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokeAwards obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.awardImagePath)
      ..writeByte(1)
      ..write(obj.obtained)
      ..writeByte(2)
      ..write(obj.awardName)
      ..writeByte(3)
      ..write(obj.cityName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokeAwardsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
