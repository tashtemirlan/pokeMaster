import 'package:pokemonmap/models/pokemonModel.dart';

class PokemonUser{
  final Pokemon pokemon;
  final int lvl;

  const PokemonUser({
    required this.pokemon,
    required this.lvl,
  });
}