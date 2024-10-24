import 'package:hive/hive.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';
part 'pokedexModel.g.dart';

@HiveType(typeId: 0)
class PokedexPokemonModel{
  @HiveField(0)
  final Pokemon pokemon;

  @HiveField(1)
  final bool isFound;

  const PokedexPokemonModel({
    required this.pokemon,
    required this.isFound,
  });
}