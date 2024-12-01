import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/pokemon_master_data_class.dart';

import '../../globals.dart';

List<PokemonTrainer> hoenn_gym_master_pokemons_1 = [
  PokemonTrainer(pokemon: pokemonsAllList[73], lvl: 14, hashPokemonTrainer: "h_Roxanne_p1"),
  PokemonTrainer(pokemon: pokemonsAllList[73], lvl: 14,  hashPokemonTrainer: "h_Roxanne_p2"),
  PokemonTrainer(pokemon: pokemonsAllList[298], lvl: 15, hashPokemonTrainer: "h_Roxanne_p3"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_2 = [
  PokemonTrainer(pokemon: pokemonsAllList[65], lvl: 16 , hashPokemonTrainer: "h_Brawly_p1"),
  PokemonTrainer(pokemon: pokemonsAllList[306], lvl: 16, hashPokemonTrainer: "h_Brawly_p2"),
  PokemonTrainer(pokemon: pokemonsAllList[295], lvl: 19, hashPokemonTrainer: "h_Brawly_p3"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[99], lvl: 20 , hashPokemonTrainer: "h_Wattson_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[308], lvl: 20, hashPokemonTrainer: "h_Wattson_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[81], lvl: 22 , hashPokemonTrainer: "h_Wattson_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[309], lvl: 24, hashPokemonTrainer: "h_Wattson_p4"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[321], lvl: 24, hashPokemonTrainer: "h_Flannery_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[217], lvl: 24, hashPokemonTrainer: "h_Flannery_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[322], lvl: 26, hashPokemonTrainer: "h_Flannery_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[323], lvl: 29, hashPokemonTrainer: "h_Flannery_p4"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_5 = [
  PokemonTrainer(pokemon:  pokemonsAllList[326], lvl: 27, hashPokemonTrainer: "h_Norman_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[287], lvl: 27, hashPokemonTrainer: "h_Norman_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[263], lvl: 29, hashPokemonTrainer: "h_Norman_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[288], lvl: 31, hashPokemonTrainer: "h_Norman_p4"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_6 = [
  PokemonTrainer(pokemon:  pokemonsAllList[332], lvl: 29, hashPokemonTrainer: "h_Winona_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[356], lvl: 29, hashPokemonTrainer: "h_Winona_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[278], lvl: 30, hashPokemonTrainer: "h_Winona_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[226], lvl: 31, hashPokemonTrainer: "h_Winona_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[333], lvl: 33, hashPokemonTrainer: "h_Winona_p5"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_7 = [
  PokemonTrainer(pokemon:  pokemonsAllList[343], lvl: 41, hashPokemonTrainer: "h_Tate_and_Liza_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[177], lvl: 41, hashPokemonTrainer: "h_Tate_and_Liza_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[336], lvl: 42, hashPokemonTrainer: "h_Tate_and_Liza_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[337], lvl: 42, hashPokemonTrainer: "h_Tate_and_Liza_p4"),
];
List<PokemonTrainer> hoenn_gym_master_pokemons_8 = [
  PokemonTrainer(pokemon:  pokemonsAllList[369], lvl: 40, hashPokemonTrainer: "h_Wallace_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[363], lvl: 40, hashPokemonTrainer: "h_Wallace_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[118], lvl: 42, hashPokemonTrainer: "h_Wallace_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[339], lvl: 42, hashPokemonTrainer: "h_Wallace_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[349], lvl: 43, hashPokemonTrainer: "h_Wallace_p5"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_1, pokeTrainerName: "Roxanne");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_2, pokeTrainerName: "Brawly");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_3, pokeTrainerName: "Wattson");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_4, pokeTrainerName: "Flannery");
PokemonMasterDataClass p5 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_5, pokeTrainerName: "Norman");
PokemonMasterDataClass p6 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_6, pokeTrainerName: "Winona");
PokemonMasterDataClass p7 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_7, pokeTrainerName: "Tate and Liza");
PokemonMasterDataClass p8 = PokemonMasterDataClass(listPokemonTrainer: hoenn_gym_master_pokemons_8, pokeTrainerName: "Wallace");

List<PokemonMasterDataClass> hoenn_gym_masters = [p1,p2,p3,p4,p5,p6,p7,p8];