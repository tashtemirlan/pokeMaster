import '../../challenge_masters_folder/pokemon_master_data_class.dart';
import '../../globals.dart';

List<PokemonTrainer> kanto_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[0], lvl: 80 , hashPokemonTrainer: "k_Big_festival_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[5], lvl: 80 , hashPokemonTrainer: "k_Big_festival_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[35], lvl: 80, hashPokemonTrainer: "k_Big_festival_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[37], lvl: 80, hashPokemonTrainer: "k_Big_festival_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[48], lvl: 80 , hashPokemonTrainer: "k_Big_festival_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[133], lvl: 80, hashPokemonTrainer: "k_Big_festival_p6"),
];

PokemonMasterDataClass masterBigFestivalKanto = PokemonMasterDataClass(listPokemonTrainer: kanto_master, pokeTrainerName: "");