import 'package:hive/hive.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRarity.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRegion.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeStats.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeType.dart';
part 'pokemonModel.g.dart';

@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  int pokeDexIndex;

  @HiveField(1)
  String name;

  @HiveField(2)
  Rarity rarity;

  @HiveField(3)
  List<PokeType> type;

  @HiveField(4)
  PokeStats pokeStats;

  @HiveField(5)
  Region region;

  @HiveField(6)
  List<PokeType?> weakness;

  @HiveField(7)
  String gifFront;

  @HiveField(8)
  String gifBack;

  Pokemon({
    required this.pokeDexIndex,
    required this.name,
    required this.rarity,
    required this.type,
    required this.pokeStats,
    required this.region,
    required this.weakness,
    required this.gifFront,
    required this.gifBack,
  });
}
