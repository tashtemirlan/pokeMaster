import '../../../models/pokemonFolder/pokemonModel.dart';

class PokemonTrainer{
  final Pokemon pokemon;
  final int lvl;
  final String hashPokemonTrainer;

  PokemonTrainer({
    required this.pokemon,
    required this.lvl,
    required this.hashPokemonTrainer
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