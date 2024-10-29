import 'package:flutter/material.dart';
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
  final VoidCallback onAllUpdate;
  const UserPokemonsTab({super.key, required this.pokemonsUser,
    required this.pokemonsUserTeam, required this.onTeamUpdate, required this.onAllUpdate});


  @override
  _UserPokemonsTabState createState() => _UserPokemonsTabState();
}

class _UserPokemonsTabState extends State<UserPokemonsTab> {

  bool isPokemonInTeam(PokemonUser pokemon) {
    return widget.pokemonsUserTeam.any((teamPokemon) => teamPokemon?.hashId == pokemon.hashId);
  }

  void viewPokeBottomSheet(PokemonUser poke) async{
    String? pokemonUserResult = await showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonUserPokedexBottomSheet(pokemonUser: poke, isPokemonInUserTeam: isPokemonInTeam(poke),);
      },
    );

    print("Pokemon result is : $pokemonUserResult");

    if(pokemonUserResult!=null){
      //Add to team or remove from it
      if(pokemonUserResult=="AddTeam" || pokemonUserResult=="DeleteTeam"){
        print("refresh user team");
        widget.onTeamUpdate();
      }
      //Release pokemon or evolve it
      else{
        print("Refreshing all");
        widget.onAllUpdate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 0,bottom: 25),
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