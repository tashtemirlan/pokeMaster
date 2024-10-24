import 'package:hive/hive.dart';
part 'pokeRarity.g.dart';

@HiveType(typeId: 4)
enum Rarity {
  @HiveField(0)
  casual,

  @HiveField(1)
  rare,

  @HiveField(2)
  epic,

  @HiveField(3)
  mystic,

  @HiveField(4)
  legendary,
}