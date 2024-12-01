import '../../globals.dart';
import '../pokemon_master_data_class.dart';

List<PokemonTrainer> jhoto_elite_master_pokemons_1 = [
  PokemonTrainer(pokemon:  pokemonsAllList[177], lvl: 55, hashPokemonTrainer: "j_Will_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[102], lvl: 55, hashPokemonTrainer: "j_Will_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[79], lvl: 55 , hashPokemonTrainer: "j_Will_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[123], lvl: 55, hashPokemonTrainer: "j_Will_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[177], lvl: 60, hashPokemonTrainer: "j_Will_p5"),
];
List<PokemonTrainer> jhoto_elite_master_pokemons_2 = [
  PokemonTrainer(pokemon:  pokemonsAllList[167], lvl: 55, hashPokemonTrainer: "j_Koga_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[204], lvl: 55, hashPokemonTrainer: "j_Koga_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[88], lvl: 55 , hashPokemonTrainer: "j_Koga_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[48], lvl: 55 , hashPokemonTrainer: "j_Koga_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[168], lvl: 60, hashPokemonTrainer: "j_Koga_p5"),
];
List<PokemonTrainer> jhoto_elite_master_pokemons_3 = [
  PokemonTrainer(pokemon:  pokemonsAllList[236], lvl: 52, hashPokemonTrainer: "j_Bruno_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[106], lvl: 52, hashPokemonTrainer: "j_Bruno_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[105], lvl: 52, hashPokemonTrainer: "j_Bruno_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[94], lvl: 52 , hashPokemonTrainer: "j_Bruno_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[67], lvl: 60 , hashPokemonTrainer: "j_Bruno_p5"),
];
List<PokemonTrainer> jhoto_elite_master_pokemons_4 = [
  PokemonTrainer(pokemon:  pokemonsAllList[196], lvl: 55, hashPokemonTrainer: "j_Karen_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[44], lvl: 55 , hashPokemonTrainer: "j_Karen_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[197], lvl: 55, hashPokemonTrainer: "j_Karen_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[228], lvl: 55, hashPokemonTrainer: "j_Karen_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[93], lvl: 60 , hashPokemonTrainer: "j_Karen_p5"),
];
List<PokemonTrainer> jhoto_master = [
  PokemonTrainer(pokemon:  pokemonsAllList[129], lvl: 76, hashPokemonTrainer: "j_Lance_p1"),
  PokemonTrainer(pokemon:  pokemonsAllList[147], lvl: 74, hashPokemonTrainer: "j_Lance_p2"),
  PokemonTrainer(pokemon:  pokemonsAllList[147], lvl: 74, hashPokemonTrainer: "j_Lance_p3"),
  PokemonTrainer(pokemon:  pokemonsAllList[141], lvl: 78, hashPokemonTrainer: "j_Lance_p4"),
  PokemonTrainer(pokemon:  pokemonsAllList[5], lvl: 78  , hashPokemonTrainer: "j_Lance_p5"),
  PokemonTrainer(pokemon:  pokemonsAllList[148], lvl: 80, hashPokemonTrainer: "j_Lance_p6"),
];

PokemonMasterDataClass p1 = PokemonMasterDataClass(listPokemonTrainer: jhoto_elite_master_pokemons_1, pokeTrainerName: "Will");
PokemonMasterDataClass p2 = PokemonMasterDataClass(listPokemonTrainer: jhoto_elite_master_pokemons_2, pokeTrainerName: "Koga");
PokemonMasterDataClass p3 = PokemonMasterDataClass(listPokemonTrainer: jhoto_elite_master_pokemons_3, pokeTrainerName: "Bruno");
PokemonMasterDataClass p4 = PokemonMasterDataClass(listPokemonTrainer: jhoto_elite_master_pokemons_4, pokeTrainerName: "Karen");
PokemonMasterDataClass masterJhoto = PokemonMasterDataClass(listPokemonTrainer: jhoto_master, pokeTrainerName: "Lance");

List<PokemonMasterDataClass> jhoto_elite_masters = [p1,p2,p3,p4];