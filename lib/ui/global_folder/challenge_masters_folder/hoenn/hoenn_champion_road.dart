import '../../globals.dart';
import '../pokemon_master_data_class.dart';

List<PokemonTrainer> hoenn_elite_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[261], lvl: 58, hashPokemonTrainer: "h_Sidney_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[274], lvl: 58, hashPokemonTrainer: "h_Sidney_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[331], lvl: 58, hashPokemonTrainer: "h_Sidney_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[341], lvl: 58, hashPokemonTrainer: "h_Sidney_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[358], lvl: 65, hashPokemonTrainer: "h_Sidney_p5"),
];
List<PokemonTrainer> hoenn_elite_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[355], lvl: 58, hashPokemonTrainer: "h_Phoebe_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[353], lvl: 58, hashPokemonTrainer: "h_Phoebe_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[301], lvl: 58, hashPokemonTrainer: "h_Phoebe_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[353], lvl: 58, hashPokemonTrainer: "h_Phoebe_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[355], lvl: 65, hashPokemonTrainer: "h_Phoebe_p5"),
];
List<PokemonTrainer> hoenn_elite_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[361], lvl: 58, hashPokemonTrainer: "h_Glacia_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[363], lvl: 58, hashPokemonTrainer: "h_Glacia_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[363], lvl: 58, hashPokemonTrainer: "h_Glacia_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[361], lvl: 58, hashPokemonTrainer: "h_Glacia_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[364], lvl: 65, hashPokemonTrainer: "h_Glacia_p5"),
];
List<PokemonTrainer> hoenn_elite_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[371], lvl: 58, hashPokemonTrainer: "h_Drake_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[333], lvl: 58, hashPokemonTrainer: "h_Drake_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[329], lvl: 58, hashPokemonTrainer: "h_Drake_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[329], lvl: 58, hashPokemonTrainer: "h_Drake_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[372], lvl: 65, hashPokemonTrainer: "h_Drake_p5"),
];
List<PokemonTrainer> hoenn_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[320], lvl: 76, hashPokemonTrainer: "h_Wallace_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[72], lvl: 74 , hashPokemonTrainer: "h_Wallace_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[271], lvl: 74, hashPokemonTrainer: "h_Wallace_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[339], lvl: 78, hashPokemonTrainer: "h_Wallace_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 78, hashPokemonTrainer: "h_Wallace_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[349], lvl: 82, hashPokemonTrainer: "h_Wallace_p6"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: hoenn_elite_master_pokemons_1, pokeTrainerName: "Sidney");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: hoenn_elite_master_pokemons_2, pokeTrainerName: "Phoebe");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: hoenn_elite_master_pokemons_3, pokeTrainerName: "Glacia");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: hoenn_elite_master_pokemons_4, pokeTrainerName: "Drake");
PokemonMasterDataClass masterHoenn = PokemonMasterDataClass(listPokemonTrainer: hoenn_master, pokeTrainerName: "Wallace ");

List<PokemonMasterDataClass> hoenn_elite_masters = [p1,p2,p3,p4];