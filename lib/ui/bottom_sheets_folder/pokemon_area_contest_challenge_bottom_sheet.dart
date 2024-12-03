import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';

import '../../models/pokeAwards.dart';
import '../../models/pokemonFolder/pokeRegion.dart';
import '../global_folder/challenge_masters_folder/pokemon_master_data_class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'battle_contest_bottom_sheet_screen.dart';

class BattleContestPreviewBottomSheetScreen extends StatefulWidget{
  final PokemonMasterDataClass pokemonListMasters;
  final PokeAwards pokeAwards;
  final bool isMaster;
  final Region region;
  const BattleContestPreviewBottomSheetScreen({super.key, required this.pokemonListMasters, required this.pokeAwards, required this.isMaster, required this.region});

  @override
  BattleContestPreviewBottomSheetScreenState createState() => BattleContestPreviewBottomSheetScreenState();
}

class BattleContestPreviewBottomSheetScreenState extends State<BattleContestPreviewBottomSheetScreen> {

  int avgLvl = 0;

  void startBattleVoid(){
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return BattleContestBottomSheetScreen(
          pokemonListMasters: widget.pokemonListMasters,
          pokeAwards: widget.pokeAwards,
          isMaster: widget.isMaster,
          region: widget.region,
        );
      },
    );
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
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.pokeAwards.cityName, style: TextStyle(fontSize: 16, color: darkBlack, decoration: TextDecoration.none),),
                ],
              ),
              SizedBox(height: 30,),
              startBattle(),
              SizedBox(height: 20,),
            ],
          ),
        )
    );
  }
}