import '../ui/global_folder/globals.dart';

class Pokemon{
  int pokeDexIndex;
  String name;
  Rarity rarity;
  List<Type> type;
  PokeStats pokeStats;
  Region region;
  List<Type?> weakness;
  String gifFront;
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
    required this.gifBack
  });
}