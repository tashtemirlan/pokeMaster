import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/ui/bottom_sheets_folder/poke_badges_bottom_sheet.dart';
import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/hoenn/hoenn_champion_road.dart';
import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/johto/johto_champion_road.dart';
import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/kalos/kalos_champion_road.dart';
import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/sinnoh/sinnoh_champion_road.dart';
import 'package:pokemonmap/ui/global_folder/challenge_masters_folder/unova/unova_champion_road.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/pokeAwards.dart';
import '../../models/pokemonFolder/pokeRegion.dart';
import '../bottom_sheets_folder/pokemon_area_challenge_bottom_sheet.dart';
import '../global_folder/challenge_masters_folder/hoenn/hoenn_area_gym_challenges.dart';
import '../global_folder/challenge_masters_folder/johto/johto_area_gym_challenges.dart';
import '../global_folder/challenge_masters_folder/kalos/kalos_area_gym_challenges.dart';
import '../global_folder/challenge_masters_folder/kanto/kanto_area_gym_challenges.dart';
import '../global_folder/challenge_masters_folder/kanto/kanto_champion_road.dart';
import '../global_folder/challenge_masters_folder/pokemon_master_data_class.dart';
import '../global_folder/challenge_masters_folder/sinnoh/sinnoh_area_gym_challenges.dart';
import '../global_folder/challenge_masters_folder/unova/unova_area_gym_challenges.dart';


class ChallengeTab extends StatefulWidget {
  @override
  _ChallengeTabState createState() => _ChallengeTabState();
}

class _ChallengeTabState extends State<ChallengeTab> {

  bool dataGet = false;
  List<List<PokeAwards>> hiveList = [];

  List<List<PokeAwards>> eliteFourChallenge = [];
  List<PokeAwards> mastersChallenge = [];

  void showAllGymBadges(){
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return PokeBadgesBottomSheet(
          showGym: true,
        );
      },
    );
  }

  void showAreaInformation(PokemonMasterDataClass pokemonMaster, PokeAwards pokeAward, bool isEliteFour, bool isMaster, Region region){
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return BattleChallengePreviewBottomSheetScreen(
          pokemonListMasters: pokemonMaster, pokeAwards: pokeAward, isEliteFour: isEliteFour, isMaster: isMaster, region:  region,
        );
      },
    );
  }

  Future<void> setDataFromHivePokedexInitialized() async {
      var box = await Hive.openBox("PokemonUserDataBase");
      List<dynamic> pokeListAwards = box.get("PokeChallenge", defaultValue: []);
      // Create a new List<List<PokeAwards>> by safely casting each sublist
      List<List<PokeAwards>> pokeListFromHive = pokeListAwards.map((dynamic sublist) {
        return (sublist as List).map((dynamic item) {
          return item as PokeAwards;  // Cast each item to PokeAwards
        }).toList();
      }).toList();

      //Here we need to get our elite 4:
      List<dynamic> pokeListEliteFourAwards = box.get("PokeChallengeElite", defaultValue: []);
      // Create a new List<List<PokeAwards>> by safely casting each sublist
      List<List<PokeAwards>> pokeListEliteFourFromHive = pokeListEliteFourAwards.map((dynamic sublist) {
        return (sublist as List).map((dynamic item) {
          return item as PokeAwards;  // Cast each item to PokeAwards
        }).toList();
      }).toList();

      //Here we got masters :
      List<dynamic> pokeListMasterAwards = box.get("PokeChallengeMaster", defaultValue: []);
      List<PokeAwards> pokeMasterList = pokeListMasterAwards.map((dynamic item) {
        return item as PokeAwards; // Cast each item to PokeAwards
      }).toList();

      setState(() {
        hiveList = pokeListFromHive;
        eliteFourChallenge = pokeListEliteFourFromHive;
        mastersChallenge = pokeMasterList;
        dataGet = true;
      });
    }

  Widget locationListGym(List<PokeAwards> pokeAwardsList, List<PokemonMasterDataClass> gymMasters, Region region) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
              showAreaInformation(gymMasters[index], pokeAwardsList[index], false, false, region);
            },
            child: Padding(
              padding: EdgeInsets.only(top: (index==0)? 0 : 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.searchBoxColor
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          pokeAwardsList[index].cityName,
                          style: TextStyle(
                              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                          )
                      ),
                      const SizedBox(width: 8,),
                      Icon(FontAwesomeIcons.mapLocationDot, color: Colors.white, size: 36,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget locationListEliteFour(List<PokemonMasterDataClass> eliteMasters, List<PokeAwards> pokeAwardsList,  Region region) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(4, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
              showAreaInformation(eliteMasters[index], pokeAwardsList[index], true, false, region);
            },
            child: Padding(
              padding: EdgeInsets.only(top: (index==0)? 0 : 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.areaEliteFour
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "${AppLocalizations.of(context)!.elite_four_string}${index+1}",
                          style: TextStyle(
                              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                          )
                      ),
                      const SizedBox(width: 8,),
                      Icon(FontAwesomeIcons.mapLocationDot, color: Colors.white, size: 36,)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget locationChampion(String regionName, PokemonMasterDataClass master, PokeAwards pokeAward,  Region region){
    return GestureDetector(
      onTap: (){
        showAreaInformation(master, pokeAward, false, true, region);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: colors.areaChampion,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${AppLocalizations.of(context)!.master_string} $regionName",
                  style: TextStyle(
                      fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                  )
              ),
              const SizedBox(width: 8,),
              Icon(FontAwesomeIcons.crown, color: Colors.white, size: 36,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setDataFromHivePokedexInitialized();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: (dataGet)? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              SizedBox(
                  width: width,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        showAllGymBadges();
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
                          child: Icon(FontAwesomeIcons.briefcase, color: Colors.white, size: 32,),
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 10,),
              //here we should gyms for each region :
              //Kanto
              Text(AppLocalizations.of(context)!.region_kanto, style: TextStyle(fontSize: 32, fontWeight:
              FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListGym(hiveList[0], kanto_gym_masters, Region.Kanto),
              const SizedBox(height: 10,),
              //we can't fight against elite 4 untill we got all region badges
              locationListEliteFour(kanto_elite_masters, eliteFourChallenge[0], Region.Kanto),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationChampion(AppLocalizations.of(context)!.region_kanto, masterKanto, mastersChallenge[0], Region.Kanto),
              const SizedBox(height: 10,),

              //Jhoto
              Text(AppLocalizations.of(context)!.region_johto,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                    color: colors.darkBlack, decoration: TextDecoration.underline), textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListGym(hiveList[1], jhoto_gym_masters, Region.Johto),
              const SizedBox(height: 10,),
              //we can't fight against elite 4 untill we got all region badges
              locationListEliteFour(jhoto_elite_masters, eliteFourChallenge[1], Region.Johto),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationChampion(AppLocalizations.of(context)!.region_johto, masterJhoto, mastersChallenge[1], Region.Johto),
              const SizedBox(height: 10,),

              //Hoenn
              Text(
                AppLocalizations.of(context)!.region_hoenn,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListGym(hiveList[2], hoenn_gym_masters, Region.Hoenn),
              const SizedBox(height: 10,),
              //we can't fight against elite 4 untill we got all region badges
              locationListEliteFour(hoenn_elite_masters, eliteFourChallenge[2], Region.Hoenn),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationChampion(AppLocalizations.of(context)!.region_hoenn, masterHoenn, mastersChallenge[2], Region.Hoenn),
              const SizedBox(height: 10,),

              //Sinnoh
              Text(
                AppLocalizations.of(context)!.region_sinnoh,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListGym(hiveList[3], sinnoh_gym_masters, Region.Sinnoh),
              const SizedBox(height: 10,),
              //we can't fight against elite 4 untill we got all region badges
              locationListEliteFour(sinnoh_elite_masters, eliteFourChallenge[3], Region.Sinnoh),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationChampion(AppLocalizations.of(context)!.region_sinnoh, masterSinnoh, mastersChallenge[3], Region.Sinnoh),
              const SizedBox(height: 10,),

              //Unova
              Text(
                AppLocalizations.of(context)!.region_unova,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListGym(hiveList[4], unova_gym_masters, Region.Unova),
              const SizedBox(height: 10,),
              //we can't fight against elite 4 untill we got all region badges
              locationListEliteFour(unova_elite_masters, eliteFourChallenge[4], Region.Unova),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationChampion(AppLocalizations.of(context)!.region_unova, masterUnova, mastersChallenge[4], Region.Unova),
              const SizedBox(height: 10,),

              //Kalos
              Text(
                AppLocalizations.of(context)!.region_kalos,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListGym(hiveList[5], kalos_gym_masters, Region.Kalos),
              const SizedBox(height: 10,),
              //we can't fight against elite 4 untill we got all region badges
              locationListEliteFour(kalos_elite_masters, eliteFourChallenge[5], Region.Kalos),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationChampion(AppLocalizations.of(context)!.region_kalos, masterKalos, mastersChallenge[5], Region.Kalos),
              const SizedBox(height: 70,),
            ],
          ) :
          CupertinoActivityIndicator(
            color: colors.colorWater,
            radius: 10,
          ),
        )
    );
  }

}