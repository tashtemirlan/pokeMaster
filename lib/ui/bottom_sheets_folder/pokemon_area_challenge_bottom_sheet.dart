import 'package:flutter/material.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';

import '../../models/pokeAwards.dart';
import '../global_folder/challenge_masters_folder/pokemon_master_data_class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BattleChallengeBottomSheetScreen extends StatefulWidget{
  final PokemonMasterDataClass pokemonListMasters;
  final PokeAwards pokeAwards;
  const BattleChallengeBottomSheetScreen({super.key, required this.pokemonListMasters, required this.pokeAwards});

  @override
  BattleChallengeBottomSheetScreenState createState() => BattleChallengeBottomSheetScreenState();
}

class BattleChallengeBottomSheetScreenState extends State<BattleChallengeBottomSheetScreen> {

  int avgLvl = 0;

  Future<void> getAverageLvlMasterPokemons() async{
    double lvlSum = 0;
    for(int i=0; i<widget.pokemonListMasters.listPokemonTrainer.length; i++){
      lvlSum += widget.pokemonListMasters.listPokemonTrainer[i].lvl;
    }
    setState(() {
      avgLvl = (lvlSum / widget.pokemonListMasters.listPokemonTrainer.length).round();
    });
  }

  Widget startBattle(){
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: colorFighting,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  AppLocalizations.of(context)!.start_battle_string,
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500 , letterSpacing: 0.1,
                      decoration: TextDecoration.none
                  )
              ),
              const SizedBox(width: 8,),
              Image.asset(
                "assets/icons/swords.png",
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAverageLvlMasterPokemons();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.pokeAwards.awardName, style: TextStyle(fontSize: 14, color: darkBlack, decoration: TextDecoration.none),),
                    SizedBox(width: 8,),
                    (widget.pokeAwards.obtained)?
                    Image.asset(
                      widget.pokeAwards.awardImagePath,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ): Image.asset(
                      widget.pokeAwards.awardImagePath,
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                      color: Colors.transparent.withOpacity(0.5),
                    ),
                    Spacer(),
                    Text(showPokemonNameCyrillic(widget.pokemonListMasters.pokeTrainerName), style: TextStyle(fontSize: 20, color: darkBlack, decoration: TextDecoration.none),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.pokeAwards.cityName, style: TextStyle(fontSize: 16, color: darkBlack, decoration: TextDecoration.none),),
                    Row(
                      children: List.generate(widget.pokemonListMasters.listPokemonTrainer.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: searchBoxColor
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.catching_pokemon_outlined, color: Colors.white, size: 18,),
                            ),
                          )
                        );
                      }),
                    ),
                    ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${AppLocalizations.of(context)!.average_lvl_string} $avgLvl", style: TextStyle(fontSize: 18, color: darkBlack, decoration: TextDecoration.none),),
                  ],
                ),
                SizedBox(height: 10,),
                startBattle(),
                SizedBox(height: 20,),
              ],
          ),
        )
    );
  }
}