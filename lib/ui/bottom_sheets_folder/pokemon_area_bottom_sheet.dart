import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonWildModel.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';

import '../../models/pokedexModel.dart';
import 'battle_bottom_sheet_screen.dart';

class PokemonAreaBottomSheet extends StatefulWidget{
  final List<PokemonWild> pokeWildList;
  final int locationNumber;
  const PokemonAreaBottomSheet({super.key, required this.pokeWildList , required this.locationNumber});

  @override
  PokemonAreaBottomSheetState createState() => PokemonAreaBottomSheetState();
}

class PokemonAreaBottomSheetState extends State<PokemonAreaBottomSheet> {

  List<PokedexPokemonModel> pokedexList = [];

  Future<void> getPokedexData() async{
    var box1 = await Hive.openBox("PokemonUserPokedex");
    List<dynamic> pokeListFromHiveDynamic1 = box1.get("Pokedex", defaultValue: []);
    List<PokedexPokemonModel> pokeListFromHive1 = pokeListFromHiveDynamic1.cast<PokedexPokemonModel>();
    setState(() {
      pokedexList = pokeListFromHive1;
    });
  }

  Future<void> startBattle() async{
    showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return BattleBottomSheetScreen(pokeWildList: widget.pokeWildList);
      },
    );
  }

  Widget _buildPokemonTile(PokemonWild wildPokemon, bool isCaught) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.scaffoldColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCaught ? Colors.green : Colors.grey,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (isCaught)?Image.asset(
            wildPokemon.pokemon.gifFront,
            height: 100,
            width: 100,
            filterQuality: FilterQuality.high,
          ) : Image.asset(
            wildPokemon.pokemon.gifFront,
            height: 100,
            width: 100,
            filterQuality: FilterQuality.high,
            color: Colors.transparent.withOpacity(0.5),
          ),
          const SizedBox(height: 5),
          Text(
            showPokemonNameCyrillic(wildPokemon.pokemon.name),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              decoration: TextDecoration.none, color: colors.darkBlack
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "${AppLocalizations.of(context)!.lvl_short_string} ${wildPokemon.lvl}",
            style: TextStyle(fontSize: 14, color: colors.darkBlack, decoration : TextDecoration.none),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPokedexData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "${AppLocalizations.of(context)!.location_map_string}${widget.locationNumber+1}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold, decoration : TextDecoration.none,
                  color: colors.darkBlack
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.pokeWildList.map((wildPokemon) {
                  bool isCaught = false;
                  for(int i=0; i<pokedexList.length;i++){
                    if(wildPokemon.pokemon.name == pokedexList[i].pokemon.name && pokedexList[i].isFound == true){
                      isCaught = true;
                      break;
                    }
                  }
                  return _buildPokemonTile(wildPokemon, isCaught);
                }).toList(),
              ),
              const SizedBox(height: 20,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                            startBattle();
                        },
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(colors.searchBoxColor)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              AppLocalizations.of(context)!.location_map_search,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        )
                    ),
                  ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
    );
  }
}