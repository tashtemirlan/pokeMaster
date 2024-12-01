import '../../globals.dart';
import '../pokemon_master_data_class.dart';

List<PokemonTrainer> sinnoh_elite_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[268], lvl: 60, hashPokemonTrainer: "s_Aaron_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[266], lvl: 60, hashPokemonTrainer: "s_Aaron_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[415], lvl: 60, hashPokemonTrainer: "s_Aaron_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[213], lvl: 60, hashPokemonTrainer: "s_Aaron_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[451], lvl: 70, hashPokemonTrainer: "s_Aaron_p5"),
];
List<PokemonTrainer> sinnoh_elite_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[194], lvl: 60, hashPokemonTrainer: "s_Bertha_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[184], lvl: 60, hashPokemonTrainer: "s_Bertha_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[75], lvl: 60 , hashPokemonTrainer: "s_Bertha_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[339], lvl: 60, hashPokemonTrainer: "s_Bertha_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[449], lvl: 70, hashPokemonTrainer: "s_Bertha_p5"),
];
List<PokemonTrainer> sinnoh_elite_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[77], lvl: 60 , hashPokemonTrainer: "s_Flint_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[135], lvl: 60, hashPokemonTrainer: "s_Flint_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[227], lvl: 60, hashPokemonTrainer: "s_Flint_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[466], lvl: 60, hashPokemonTrainer: "s_Flint_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[391], lvl: 70, hashPokemonTrainer: "s_Flint_p5"),
];
List<PokemonTrainer> sinnoh_elite_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[121], lvl: 60, hashPokemonTrainer: "s_Lucian_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[202], lvl: 60, hashPokemonTrainer: "s_Lucian_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[307], lvl: 60, hashPokemonTrainer: "s_Lucian_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[64], lvl: 60 , hashPokemonTrainer: "s_Lucian_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[436], lvl: 70, hashPokemonTrainer: "s_Lucian_p5"),
];
List<PokemonTrainer> sinnoh_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[441], lvl: 80, hashPokemonTrainer: "s_Cynthia_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[406], lvl: 80, hashPokemonTrainer: "s_Cynthia_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[467], lvl: 80, hashPokemonTrainer: "s_Cynthia_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[349], lvl: 80, hashPokemonTrainer: "s_Cynthia_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[447], lvl: 80, hashPokemonTrainer: "s_Cynthia_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[444], lvl: 90, hashPokemonTrainer: "s_Cynthia_p6"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: sinnoh_elite_master_pokemons_1, pokeTrainerName: "Aaron");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: sinnoh_elite_master_pokemons_2, pokeTrainerName: "Bertha");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: sinnoh_elite_master_pokemons_3, pokeTrainerName: "Flint");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: sinnoh_elite_master_pokemons_4, pokeTrainerName: "Lucian");
PokemonMasterDataClass masterSinnoh = PokemonMasterDataClass(listPokemonTrainer: sinnoh_master, pokeTrainerName: "Cynthia");

List<PokemonMasterDataClass> sinnoh_elite_masters = [p1,p2,p3,p4];