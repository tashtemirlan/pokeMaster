import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/pokemon_master_data_class.dart';

import '../../globals.dart';

List<PokemonTrainer> jhoto_gym_master_pokemons_1 = [
  PokemonTrainer(pokemon: pokemonsAllList[15], lvl: 9 , hashPokemonTrainer: "j_Falkner_p1"),
  PokemonTrainer(pokemon: pokemonsAllList[16], lvl: 13, hashPokemonTrainer: "j_Falkner_p2"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_2 = [
  PokemonTrainer(pokemon: pokemonsAllList[122], lvl: 17, hashPokemonTrainer: "j_Bugsy_p1"),
  PokemonTrainer(pokemon: pokemonsAllList[10], lvl: 15 , hashPokemonTrainer: "j_Bugsy_p2"),
  PokemonTrainer(pokemon: pokemonsAllList[13], lvl: 15 , hashPokemonTrainer: "j_Bugsy_p3"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[34], lvl: 17 , hashPokemonTrainer: "j_Whitney_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[240], lvl: 19, hashPokemonTrainer: "j_Whitney_p2"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[91], lvl: 21, hashPokemonTrainer: "j_Morty_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[92], lvl: 21, hashPokemonTrainer: "j_Morty_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[93], lvl: 25, hashPokemonTrainer: "j_Morty_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[92], lvl: 23, hashPokemonTrainer: "j_Morty_p4"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_5 = [
  PokemonTrainer(pokemon:  pokemonsAllList[56], lvl: 29, hashPokemonTrainer: "j_Chuck_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[61], lvl: 31, hashPokemonTrainer: "j_Chuck_p2"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_6 = [
  PokemonTrainer(pokemon:  pokemonsAllList[80], lvl: 30 , hashPokemonTrainer: "j_Jasmine_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[80], lvl: 30 , hashPokemonTrainer: "j_Jasmine_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[207], lvl: 35, hashPokemonTrainer: "j_Jasmine_p3"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_7 = [
  PokemonTrainer(pokemon:  pokemonsAllList[85], lvl: 30 , hashPokemonTrainer: "j_Pryce_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[86], lvl: 32 , hashPokemonTrainer: "j_Pryce_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[220], lvl: 34, hashPokemonTrainer: "j_Pryce_p3"),
];
List<PokemonTrainer> jhoto_gym_master_pokemons_8 = [
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 38, hashPokemonTrainer: "j_Clair_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[147], lvl: 38, hashPokemonTrainer: "j_Clair_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[147], lvl: 38, hashPokemonTrainer: "j_Clair_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[229], lvl: 41, hashPokemonTrainer: "j_Clair_p4"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_1, pokeTrainerName: "Falkner");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_2, pokeTrainerName: "Bugsy");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_3, pokeTrainerName: "Whitney");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_4, pokeTrainerName: "Morty");
PokemonMasterDataClass p5 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_5, pokeTrainerName: "Chuck");
PokemonMasterDataClass p6 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_6, pokeTrainerName: "Jasmine");
PokemonMasterDataClass p7 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_7, pokeTrainerName: "Pryce");
PokemonMasterDataClass p8 = PokemonMasterDataClass(listPokemonTrainer: jhoto_gym_master_pokemons_8, pokeTrainerName: "Clair");

List<PokemonMasterDataClass> jhoto_gym_masters = [p1,p2,p3,p4,p5,p6,p7,p8];