import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/pokemon_master_data_class.dart';

import '../../globals.dart';

List<PokemonTrainer> kanto_gym_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[73], lvl: 22, hashPokemonTrainer: "k_Brock_p1"),
  PokemonTrainer(pokemon: pokemonsAllList[184], lvl: 28, hashPokemonTrainer: "k_Brock_p2"),
  PokemonTrainer(pokemon: pokemonsAllList[207], lvl: 44, hashPokemonTrainer: "k_Brock_p3"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[119], lvl: 22, hashPokemonTrainer: "k_Misty_p1"),
  PokemonTrainer(pokemon: pokemonsAllList[120], lvl: 33 , hashPokemonTrainer: "k_Misty_p2"),
  PokemonTrainer(pokemon: pokemonsAllList[53], lvl: 33  , hashPokemonTrainer: "k_Misty_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 44, hashPokemonTrainer: "k_Misty_p4"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[25], lvl: 44 , hashPokemonTrainer: "k_Surge_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[100], lvl: 33, hashPokemonTrainer: "k_Surge_p2"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[113], lvl: 44, hashPokemonTrainer: "k_Erika_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[69], lvl: 44 , hashPokemonTrainer: "k_Erika_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[43], lvl: 44 , hashPokemonTrainer: "k_Erika_p3"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_5 = [
  PokemonTrainer(pokemon:  pokemonsAllList[48], lvl: 44 , hashPokemonTrainer: "k_Koga_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[41], lvl: 44 , hashPokemonTrainer: "k_Koga_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[122], lvl: 44, hashPokemonTrainer: "k_Koga_p3"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_6 = [
  PokemonTrainer(pokemon:  pokemonsAllList[62], lvl: 33, hashPokemonTrainer: "k_Sabrina_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[63], lvl: 44, hashPokemonTrainer: "k_Sabrina_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[64], lvl: 55, hashPokemonTrainer: "k_Sabrina_p3"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_7 = [
  PokemonTrainer(pokemon:  pokemonsAllList[37], lvl: 44 , hashPokemonTrainer: "k_Blaine_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[111], lvl: 44, hashPokemonTrainer: "k_Blaine_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[125], lvl: 44, hashPokemonTrainer: "k_Blaine_p3"),
];
List<PokemonTrainer> kanto_gym_master_pokemons_8 = [
  PokemonTrainer(pokemon:  pokemonsAllList[98], lvl: 44 , hashPokemonTrainer: "k_Giovanni_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[67], lvl: 44 , hashPokemonTrainer: "k_Giovanni_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[111], lvl: 44, hashPokemonTrainer: "k_Giovanni_p3"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_1, pokeTrainerName: "Brock");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_2, pokeTrainerName: "Misty");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_3, pokeTrainerName: "Lt. Surge");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_4, pokeTrainerName: "Erika");
PokemonMasterDataClass p5 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_5, pokeTrainerName: "Koga");
PokemonMasterDataClass p6 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_6, pokeTrainerName: "Sabrina");
PokemonMasterDataClass p7 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_7, pokeTrainerName: "Blaine");
PokemonMasterDataClass p8 = PokemonMasterDataClass(listPokemonTrainer: kanto_gym_master_pokemons_8, pokeTrainerName: "Giovanni");

List<PokemonMasterDataClass> kanto_gym_masters = [p1,p2,p3,p4,p5,p6,p7,p8];