import '../../../models/pokemonFolder/pokemonModel.dart';

class PokemonTrainer{
  final Pokemon pokemon;
  final int lvl;

  PokemonTrainer({
    required this.pokemon,
    required this.lvl,
  });
}

class PokemonMasterDataClass{
  final List<PokemonTrainer> listPokemonTrainer;
  final String pokeTrainerName;

  PokemonMasterDataClass({
    required this.listPokemonTrainer,
    required this.pokeTrainerName,
  });
}