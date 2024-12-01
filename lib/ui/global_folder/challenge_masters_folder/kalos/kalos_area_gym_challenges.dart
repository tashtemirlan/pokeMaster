import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/pokemon_master_data_class.dart';

import '../../globals.dart';

List<PokemonTrainer> kalos_gym_master_pokemons_1 = [
  PokemonTrainer(lvl: 10, pokemon: pokemonsAllList[282], hashPokemonTrainer: "ka_Viola_p1"),
  PokemonTrainer(lvl: 12, pokemon: pokemonsAllList[665], hashPokemonTrainer: "ka_Viola_p2"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_2 = [
  PokemonTrainer(lvl: 25, pokemon: pokemonsAllList[697], hashPokemonTrainer: "ka_Grant_p1"),
  PokemonTrainer(lvl: 25, pokemon: pokemonsAllList[695], hashPokemonTrainer: "ka_Grant_p2"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_3 = [
  PokemonTrainer(lvl: 29, pokemon:  pokemonsAllList[618], hashPokemonTrainer: "ka_Korrina_p1"),
  PokemonTrainer(lvl: 28, pokemon:  pokemonsAllList[66] , hashPokemonTrainer: "ka_Korrina_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[700], lvl: 32, hashPokemonTrainer: "ka_Korrina_p3"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_4 = [
  PokemonTrainer(lvl: 30, pokemon:  pokemonsAllList[188], hashPokemonTrainer: "ka_Ramos_p1"),
  PokemonTrainer(lvl: 31, pokemon:  pokemonsAllList[69] , hashPokemonTrainer: "ka_Ramos_p2"),
  PokemonTrainer(lvl: 34, pokemon:  pokemonsAllList[672], hashPokemonTrainer: "ka_Ramos_p3"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_5 = [
  PokemonTrainer(lvl: 35, pokemon:  pokemonsAllList[586], hashPokemonTrainer: "ka_Clemont_p1"),
  PokemonTrainer(lvl: 35, pokemon:  pokemonsAllList[81] , hashPokemonTrainer: "ka_Clemont_p2"),
  PokemonTrainer(lvl: 37, pokemon:  pokemonsAllList[94] , hashPokemonTrainer: "ka_Clemont_p3"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_6 = [
  PokemonTrainer(lvl: 38, pokemon:  pokemonsAllList[302], hashPokemonTrainer: "ka_Valerie_p1"),
  PokemonTrainer(lvl: 39, pokemon:  pokemonsAllList[121], hashPokemonTrainer: "ka_Valerie_p2"),
  PokemonTrainer(lvl: 42, pokemon:  pokemonsAllList[699], hashPokemonTrainer: "ka_Valerie_p3"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_7 = [
  PokemonTrainer(lvl: 44, pokemon:  pokemonsAllList[560], hashPokemonTrainer: "ka_Olympia_p1"),
  PokemonTrainer(lvl: 45, pokemon:  pokemonsAllList[198], hashPokemonTrainer: "ka_Olympia_p2"),
  PokemonTrainer(lvl: 48, pokemon:  pokemonsAllList[677], hashPokemonTrainer: "ka_Olympia_p3"),
];
List<PokemonTrainer> kalos_gym_master_pokemons_8 = [
  PokemonTrainer(lvl: 56, pokemon:  pokemonsAllList[459], hashPokemonTrainer: "ka_Wulfric_p1"),
  PokemonTrainer(lvl: 55, pokemon:  pokemonsAllList[614], hashPokemonTrainer: "ka_Wulfric_p2"),
  PokemonTrainer(lvl: 59, pokemon:  pokemonsAllList[712], hashPokemonTrainer: "ka_Wulfric_p3"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_1, pokeTrainerName: "Viola");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_2, pokeTrainerName: "Grant");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_3, pokeTrainerName: "Korrina");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_4, pokeTrainerName: "Ramos");
PokemonMasterDataClass p5 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_5, pokeTrainerName: "Clemont");
PokemonMasterDataClass p6 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_6, pokeTrainerName: "Valerie");
PokemonMasterDataClass p7 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_7, pokeTrainerName: "Olympia");
PokemonMasterDataClass p8 = PokemonMasterDataClass(listPokemonTrainer: kalos_gym_master_pokemons_8, pokeTrainerName: "Wulfric");

List<PokemonMasterDataClass> kalos_gym_masters = [p1,p2,p3,p4,p5,p6,p7,p8];