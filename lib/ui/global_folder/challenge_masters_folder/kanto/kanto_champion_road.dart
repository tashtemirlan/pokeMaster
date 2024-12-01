import '../../globals.dart';
import '../pokemon_master_data_class.dart';

List<PokemonTrainer> kanto_elite_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[86], lvl: 52 , hashPokemonTrainer: "k_Lorelei_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[90], lvl: 52 , hashPokemonTrainer: "k_Lorelei_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[79], lvl: 52 , hashPokemonTrainer: "k_Lorelei_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[123], lvl: 52, hashPokemonTrainer: "k_Lorelei_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[130], lvl: 60, hashPokemonTrainer: "k_Lorelei_p5"),
];
List<PokemonTrainer> kanto_elite_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[94], lvl: 52 , hashPokemonTrainer: "k_Bruno_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[106], lvl: 52, hashPokemonTrainer: "k_Bruno_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[105], lvl: 52, hashPokemonTrainer: "k_Bruno_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[94], lvl: 52 , hashPokemonTrainer: "k_Bruno_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[67], lvl: 60 , hashPokemonTrainer: "k_Bruno_p5"),
];
List<PokemonTrainer> kanto_elite_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[93], lvl: 52, hashPokemonTrainer: "k_Agatha_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[41], lvl: 52, hashPokemonTrainer: "k_Agatha_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[92], lvl: 52, hashPokemonTrainer: "k_Agatha_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[23], lvl: 52, hashPokemonTrainer: "k_Agatha_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[93], lvl: 60, hashPokemonTrainer: "k_Agatha_p5"),
];
List<PokemonTrainer> kanto_elite_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 52, hashPokemonTrainer: "k_Lance_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[147], lvl: 52, hashPokemonTrainer: "k_Lance_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[147], lvl: 52, hashPokemonTrainer: "k_Lance_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[141], lvl: 52, hashPokemonTrainer: "k_Lance_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[5], lvl: 52  , hashPokemonTrainer: "k_Lance_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[148], lvl: 60, hashPokemonTrainer: "k_Lance_p6"),
];
List<PokemonTrainer> kanto_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[64], lvl: 76 , hashPokemonTrainer: "k_Garry_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[17], lvl: 74 , hashPokemonTrainer: "k_Garry_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[111], lvl: 74, hashPokemonTrainer: "k_Garry_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[102], lvl: 78, hashPokemonTrainer: "k_Garry_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[58], lvl: 78 , hashPokemonTrainer: "k_Garry_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 80, hashPokemonTrainer: "k_Garry_p6"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: kanto_elite_master_pokemons_1, pokeTrainerName: "Lorelei");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: kanto_elite_master_pokemons_2, pokeTrainerName: "Bruno");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: kanto_elite_master_pokemons_3, pokeTrainerName: "Agatha");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: kanto_elite_master_pokemons_4, pokeTrainerName: "Lance");
PokemonMasterDataClass masterKanto = PokemonMasterDataClass(listPokemonTrainer: kanto_master, pokeTrainerName: "Garry");

List<PokemonMasterDataClass> kanto_elite_masters = [p1,p2,p3,p4];