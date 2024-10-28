import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonUser.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';

import '../bottom_sheets_folder/pokemon_user_pokedex_bottom_sheet.dart';


class UserPokemonsTab extends StatefulWidget {
  final List<PokemonUser> pokemonsUser;
  final List<PokemonUser?> pokemonsUserTeam;
  final VoidCallback onTeamUpdate;
  const UserPokemonsTab({super.key, required this.pokemonsUser,
    required this.pokemonsUserTeam, required this.onTeamUpdate});


  @override
  _UserPokemonsTabState createState() => _UserPokemonsTabState();
}

class _UserPokemonsTabState extends State<UserPokemonsTab> {

  bool isPokemonInTeam(PokemonUser pokemon) {
    return widget.pokemonsUserTeam.any((teamPokemon) => teamPokemon?.hashId == pokemon.hashId);
  }

  Future<void> addToTeam(PokemonUser poke) async{
    var box = await Hive.openBox("PokemonUserTeam");
    List<dynamic> pokeListFromHiveDynamic = box.get("UserTeam", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();
    if(pokeListFromHive.length >=5 || isPokemonInTeam(poke)){
      print("Here is already so much pokemons!");
    }
    else{
      pokeListFromHive.add(poke);
      box.put("UserTeam", pokeListFromHive);
      widget.onTeamUpdate();
    }
  }

  void viewPokeBottomSheet(PokemonUser poke) async{
    PokemonUser? pokemonUserResult = await showCupertinoModalBottomSheet<PokemonUser>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonUserPokedexBottomSheet(pokemonUser: poke,);
      },
    );

    if(pokemonUserResult!=null){
      addToTeam(pokemonUserResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.pokemonsUser.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          final pokemon = widget.pokemonsUser[index];
          final isInTeam = isPokemonInTeam(pokemon);

          return GestureDetector(
            onTap: () {
              viewPokeBottomSheet(pokemon);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isInTeam ? Colors.orange : Colors.grey,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  // Pokémon Image and Level
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      pokemon.pokemon.gifFront,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Text(
                    showPokemonNameCyrillic(pokemon.pokemon.name), overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.lvl_short_string} ${pokemon.lvl}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}