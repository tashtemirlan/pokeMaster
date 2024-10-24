import 'package:hive/hive.dart';
part 'pokeType.g.dart';


@HiveType(typeId: 5)
enum PokeType {
  @HiveField(0)
  Normal,

  @HiveField(1)
  Fire,

  @HiveField(2)
  Water,

  @HiveField(3)
  Electric,

  @HiveField(4)
  Grass,

  @HiveField(5)
  Ice,

  @HiveField(6)
  Fighting,

  @HiveField(7)
  Poison,

  @HiveField(8)
  Ground,

  @HiveField(9)
  Flying,

  @HiveField(10)
  Psychic,

  @HiveField(11)
  Bug,

  @HiveField(12)
  Rock,

  @HiveField(13)
  Ghost,

  @HiveField(14)
  Dragon,

  @HiveField(15)
  Dark,

  @HiveField(16)
  Steel,

  @HiveField(17)
  Fairy,
}