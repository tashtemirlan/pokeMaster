import '../../globals.dart';
import '../pokemon_master_data_class.dart';

List<PokemonTrainer> unova_elite_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[562], lvl: 60, hashPokemonTrainer: "u_Shauntal_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[425], lvl: 60, hashPokemonTrainer: "u_Shauntal_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[622], lvl: 60, hashPokemonTrainer: "u_Shauntal_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[353], lvl: 60, hashPokemonTrainer: "u_Shauntal_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[608], lvl: 70, hashPokemonTrainer: "u_Shauntal_p5"),
];
List<PokemonTrainer> unova_elite_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[537], lvl: 60, hashPokemonTrainer: "u_Marshal_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[538], lvl: 60, hashPokemonTrainer: "u_Marshal_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[447], lvl: 60, hashPokemonTrainer: "u_Marshal_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[533], lvl: 60, hashPokemonTrainer: "u_Marshal_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[619], lvl: 70, hashPokemonTrainer: "u_Marshal_p5"),
];
List<PokemonTrainer> unova_elite_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[519], lvl: 60, hashPokemonTrainer: "u_Grimsley_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[559], lvl: 60, hashPokemonTrainer: "u_Grimsley_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[552], lvl: 60, hashPokemonTrainer: "u_Grimsley_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[358], lvl: 60, hashPokemonTrainer: "u_Grimsley_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[624], lvl: 70, hashPokemonTrainer: "u_Grimsley_p5"),
];
List<PokemonTrainer> unova_elite_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[517], lvl: 60, hashPokemonTrainer: "u_Caitlin_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[578], lvl: 60, hashPokemonTrainer: "u_Caitlin_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[560], lvl: 60, hashPokemonTrainer: "u_Caitlin_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[375], lvl: 60, hashPokemonTrainer: "u_Caitlin_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[575], lvl: 70, hashPokemonTrainer: "u_Caitlin_p5"),
];
List<PokemonTrainer> unova_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[634], lvl: 70, hashPokemonTrainer: "u_Iris_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[620], lvl: 70, hashPokemonTrainer: "u_Iris_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[566], lvl: 70, hashPokemonTrainer: "u_Iris_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[305], lvl: 70, hashPokemonTrainer: "u_Iris_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[130], lvl: 70, hashPokemonTrainer: "u_Iris_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[611], lvl: 80, hashPokemonTrainer: "u_Iris_p6"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: unova_elite_master_pokemons_1, pokeTrainerName: "Shauntal");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: unova_elite_master_pokemons_2, pokeTrainerName: "Marshal");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: unova_elite_master_pokemons_3, pokeTrainerName: "Grimsley");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: unova_elite_master_pokemons_4, pokeTrainerName: "Caitlin");
PokemonMasterDataClass masterUnova = PokemonMasterDataClass(listPokemonTrainer: unova_master, pokeTrainerName: "Iris");

List<PokemonMasterDataClass> unova_elite_masters = [p1,p2,p3,p4];