import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonUser.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';

import '../../models/pokemonFolder/pokeType.dart';
import '../bottom_sheets_folder/pokemon_user_pokedex_bottom_sheet.dart';

class UserPokemonsTab extends StatefulWidget {
  final List<PokemonUser> pokemonsUser;
  final List<PokemonUser?> pokemonsUserTeam;
  final VoidCallback onTeamUpdate;
  final VoidCallback onAllUpdate;
  const UserPokemonsTab({super.key, required this.pokemonsUser,
    required this.pokemonsUserTeam, required this.onTeamUpdate, required this.onAllUpdate});


  @override
  UserPokemonsTabState createState() => UserPokemonsTabState();
}

class UserPokemonsTabState extends State<UserPokemonsTab> {

  bool sortDescend = true;
  List<PokemonUser> filteredList = [];
  bool dataGet = false;
  PokeType? selectedType;

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

    if(pokemonUserResult!=null){
      //Add to team or remove from it
      if(pokemonUserResult=="AddTeam" || pokemonUserResult=="DeleteTeam"){
        widget.onTeamUpdate();
        await updateDataUI();
      }
      //Release pokemon or evolve it
      else{
        widget.onAllUpdate();
        await updateDataUI();
      }
    }
  }

  Future<void> updateDataUI() async{
    setState(() {
      dataGet = false;
    });
    setData();
  }

  Future<void> toggleSortOrder() async{
    setState(() {
      // Toggle sorting order
      sortDescend = !sortDescend;
      filteredList.sort((a, b) =>
      sortDescend ? b.lvl.compareTo(a.lvl) : a.lvl.compareTo(b.lvl));
    });
  }

  Future<void> setData() async{
    filteredList = List.from(widget.pokemonsUser);
    await toggleSortOrder();
    setState(() {
      dataGet = true;
    });
  }

  void _sortPokemonByType(PokeType? type) {
    setState(() {
      selectedType = type; // Update the selected type

      if (type == null) {
        // No type selected, show all Pokémon
        filteredList = List.from(widget.pokemonsUser);
      } else {
        // Filter Pokémon by the selected type
        filteredList = widget.pokemonsUser.where((pokemon) {
          return pokemon.pokemon.type.contains(type);
        }).toList();
      }

      // Sort filtered Pokémon list
      filteredList.sort((a, b) =>
      sortDescend ? b.lvl.compareTo(a.lvl) : a.lvl.compareTo(b.lvl));
    });
  }

  Widget _buildTypeContainer(PokeType type, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          _sortPokemonByType(type == selectedType ? null : type);
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 0,bottom: 25),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async{
                    await toggleSortOrder();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.searchBoxColor
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: (sortDescend)?
                      Icon(FontAwesomeIcons.arrowUpWideShort, color: Colors.white, size: 24,) :
                      Icon(FontAwesomeIcons.arrowDownWideShort, color: Colors.white, size: 24,),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                // Pokémon Type Icons
                _buildTypeContainer(PokeType.Normal, Colors.grey, FontAwesomeIcons.circle),
                _buildTypeContainer(PokeType.Fire, Colors.red, FontAwesomeIcons.fire),
                _buildTypeContainer(PokeType.Water, Colors.blue, FontAwesomeIcons.water),
                _buildTypeContainer(PokeType.Electric, Colors.yellow, FontAwesomeIcons.bolt),
                _buildTypeContainer(PokeType.Grass, Colors.green, FontAwesomeIcons.leaf),
                _buildTypeContainer(PokeType.Ice, Colors.lightBlueAccent, FontAwesomeIcons.snowflake),
                _buildTypeContainer(PokeType.Fighting, Colors.brown, FontAwesomeIcons.fistRaised),
                _buildTypeContainer(PokeType.Poison, Colors.purple, FontAwesomeIcons.skullCrossbones),
                _buildTypeContainer(PokeType.Ground, Colors.orange, FontAwesomeIcons.mountain),
                _buildTypeContainer(PokeType.Flying, Colors.lightBlue, FontAwesomeIcons.feather),
                _buildTypeContainer(PokeType.Psychic, Colors.pink, FontAwesomeIcons.eye),
                _buildTypeContainer(PokeType.Bug, Colors.lightGreen, FontAwesomeIcons.bug),
                _buildTypeContainer(PokeType.Rock, Colors.brown, FontAwesomeIcons.stop),
                _buildTypeContainer(PokeType.Ghost, Colors.deepPurple, FontAwesomeIcons.ghost),
                _buildTypeContainer(PokeType.Dragon, Colors.indigo, FontAwesomeIcons.dragon),
                _buildTypeContainer(PokeType.Dark, Colors.black, FontAwesomeIcons.moon),
                _buildTypeContainer(PokeType.Steel, Colors.blueGrey, FontAwesomeIcons.shieldAlt),
                _buildTypeContainer(PokeType.Fairy, Colors.pinkAccent, FontAwesomeIcons.magic),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
              child: (dataGet)? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                padding: EdgeInsets.only(bottom: 80),
                itemBuilder: (context, index) {
                  final pokemon = filteredList[index];
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
              ) :
                  CupertinoActivityIndicator(
                    color: colors.colorBug,
                    radius: 10,
                  )
          ),
        ],
      ),
    );
  }
}