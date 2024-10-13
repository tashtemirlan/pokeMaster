import 'package:pokemonmap/models/pokemonModel.dart';

class PokedexPokemonModel{
  final Pokemon pokemon;
  final bool isFound;

  const PokedexPokemonModel({
    required this.pokemon,
    required this.isFound,
  });
}