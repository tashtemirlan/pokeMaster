import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRegion.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';

import '../../models/pokeAwards.dart';
import '../global_folder/challenge_masters_folder/pokemon_master_data_class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'batlle_challenge_bottom_sheet_screen.dart';

class BattleChallengePreviewBottomSheetScreen extends StatefulWidget{
  final PokemonMasterDataClass pokemonListMasters;
  final PokeAwards pokeAwards;
  final bool isEliteFour;
  final bool isMaster;
  final Region region;
  const BattleChallengePreviewBottomSheetScreen({super.key, required this.pokemonListMasters,
    required this.pokeAwards, required this.isEliteFour, required this.isMaster, required this.region});

  @override
  BattleChallengePreviewBottomSheetScreenState createState() => BattleChallengePreviewBottomSheetScreenState();
}

class BattleChallengePreviewBottomSheetScreenState extends State<BattleChallengePreviewBottomSheetScreen> {

  int avgLvl = 0;

  void startBattleVoid(){
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return BattleChallengeBottomSheetScreen(pokemonListMasters: widget.pokemonListMasters,
          pokeAwards: widget.pokeAwards, isEliteFour: widget.isEliteFour, isMaster: widget.isMaster, region: widget.region,);
      },
    );
  }

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
        startBattleVoid();
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
                SizedBox(height: 20,),
                startBattle(),
                SizedBox(height: 20,),
              ],
          ),
        )
    );
  }
}