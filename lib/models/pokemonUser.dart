import 'package:hive/hive.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';
part 'pokemonUser.g.dart';

@HiveType(typeId: 7)
class PokemonUser{
  @HiveField(0)
  final Pokemon pokemon;

  @HiveField(1)
  final int lvl;

  @HiveField(2)
  final String hashId;

  @HiveField(3)
  final int pokemonExp;

  const PokemonUser({
    required this.pokemon,
    required this.lvl,
    required this.hashId,
    required this.pokemonExp
  });
}