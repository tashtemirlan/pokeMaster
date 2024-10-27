import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../models/pokeAwards.dart';

//todo :=> multiple choice radio buttons with check right
class PokeBadgesBottomSheet extends StatefulWidget{
  final bool showGym;
  const PokeBadgesBottomSheet({super.key, required this.showGym});

  @override
  PokeBadgesBottomSheetState createState() => PokeBadgesBottomSheetState();
}

class PokeBadgesBottomSheetState extends State<PokeBadgesBottomSheet> {

  bool dataGet = false;
  List<List<PokeAwards>> hiveList = [];

  Widget storeItem(double width, PokeAwards shopItem) {
    return Container(
      width: width*0.4,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InstaImageViewer(
                  backgroundColor: Colors.white,
                  child: (shopItem.obtained)? Image.asset(
                    shopItem.awardImagePath,
                    height: 80,
                    fit: BoxFit.contain,
                  ) : Image.asset(
                    shopItem.awardImagePath,
                    height: 80,
                    fit: BoxFit.contain,
                    color: Colors.transparent.withOpacity(0.5),
                  )
              ),
              SizedBox(height: 8.0),
              // Item name
              Text(
                shopItem.awardName,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.darkBlack,
                    decoration: TextDecoration.none
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.0),
              // Item city name
              Text(
                shopItem.cityName,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.darkBlack,
                    decoration: TextDecoration.none
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
      )
    );
  }

  Widget storeItems(double width, List<PokeAwards> eventList){
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: eventList.map((item){
        return storeItem(width, item);
      }).toList(),
    );
  }

  Widget regionGymAwards(String regionName, double width, List<PokeAwards> pokeAwards){
    return Column(
      children: [
        Text(
          regionName,
          style: TextStyle(fontSize: 28, fontWeight:
          FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.none),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15,),
        storeItems(width, pokeAwards)
      ],
    );
  }

  Future<void> setDataFromHivePokedexInitialized() async {
    var box = await Hive.openBox("PokemonUserDataBase");

    if (widget.showGym) {
      List<dynamic> pokeListAwards = box.get("PokeChallenge", defaultValue: []);
      log("${pokeListAwards.length}");
      // Create a new List<List<PokeAwards>> by safely casting each sublist
      List<List<PokeAwards>> pokeListFromHive = pokeListAwards.map((dynamic sublist) {
        return (sublist as List).map((dynamic item) {
          return item as PokeAwards;  // Cast each item to PokeAwards
        }).toList();
      }).toList();

      setState(() {
        hiveList = pokeListFromHive;
        dataGet = true;
      });
    } else {
      List<dynamic> pokeListAwards = box.get("PokeContest", defaultValue: []);
      log("${pokeListAwards.length}");
      // Similar safe casting for contest awards
      List<List<PokeAwards>> pokeListFromHive = pokeListAwards.map((dynamic sublist) {
        return (sublist as List).map((dynamic item) {
          return item as PokeAwards;
        }).toList();
      }).toList();

      setState(() {
        hiveList = pokeListFromHive;
        dataGet = true;
      });
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: (dataGet)?
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_kanto,
                  width, hiveList[0]),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_johto,
                  width, hiveList[1]),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_hoenn,
                  width, hiveList[2]),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_sinnoh,
                  width, hiveList[3]),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_unova,
                  width, hiveList[4]),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_kalos,
                  width, hiveList[5]),
              const SizedBox(height: 20,)
            ],
          ) :
          Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade400,
              strokeWidth: 7,
            ),
          ),
        )
    );
  }
}