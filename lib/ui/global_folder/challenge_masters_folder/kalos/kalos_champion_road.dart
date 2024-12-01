import '../../globals.dart';
import '../pokemon_master_data_class.dart';

List<PokemonTrainer> kalos_elite_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[667], lvl: 60, hashPokemonTrainer: "ka_Malva_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[323], lvl: 60, hashPokemonTrainer: "ka_Malva_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[608], lvl: 60, hashPokemonTrainer: "ka_Malva_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[662], lvl: 70, hashPokemonTrainer: "ka_Malva_p4"),
];
List<PokemonTrainer> kalos_elite_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[692], lvl: 60, hashPokemonTrainer: "ka_Siebold_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 60, hashPokemonTrainer: "ka_Siebold_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[120], lvl: 60, hashPokemonTrainer: "ka_Siebold_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[688], lvl: 70, hashPokemonTrainer: "ka_Siebold_p4"),
];
List<PokemonTrainer> kalos_elite_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[706], lvl: 60, hashPokemonTrainer: "ka_Wikstrom_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[475], lvl: 60, hashPokemonTrainer: "ka_Wikstrom_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[211], lvl: 60, hashPokemonTrainer: "ka_Wikstrom_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[680], lvl: 70, hashPokemonTrainer: "ka_Wikstrom_p4"),
];
List<PokemonTrainer> kalos_elite_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[690], lvl: 60, hashPokemonTrainer: "ka_Drasna_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[620], lvl: 60, hashPokemonTrainer: "ka_Drasna_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[333], lvl: 60, hashPokemonTrainer: "ka_Drasna_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[714], lvl: 70, hashPokemonTrainer: "ka_Drasna_p4"),
];
List<PokemonTrainer> kalos_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[700], lvl: 70, hashPokemonTrainer: "ka_Diantha_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[696], lvl: 70, hashPokemonTrainer: "ka_Diantha_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[698], lvl: 70, hashPokemonTrainer: "ka_Diantha_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[710], lvl: 70, hashPokemonTrainer: "ka_Diantha_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[705], lvl: 70, hashPokemonTrainer: "ka_Diantha_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[281], lvl: 80, hashPokemonTrainer: "ka_Diantha_p6"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: kalos_elite_master_pokemons_1, pokeTrainerName: "Malva");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: kalos_elite_master_pokemons_2, pokeTrainerName: "Siebold");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: kalos_elite_master_pokemons_3, pokeTrainerName: "Wikstrom");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: kalos_elite_master_pokemons_4, pokeTrainerName: "Drasna");
PokemonMasterDataClass masterKalos = PokemonMasterDataClass(listPokemonTrainer: kalos_master, pokeTrainerName: "Diantha");

List<PokemonMasterDataClass> kalos_elite_masters = [p1,p2,p3,p4];