import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:pokemonmap/ui/bottom_navigation_folder/shopPage.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;


import '../global_folder/globals.dart';

//todo :=> multiple choice radio buttons with check right
class PokeBadgesBottomSheet extends StatefulWidget{
  final bool showGym;
  const PokeBadgesBottomSheet({super.key, required this.showGym});

  @override
  PokeBadgesBottomSheetState createState() => PokeBadgesBottomSheetState();
}

class PokeBadgesBottomSheetState extends State<PokeBadgesBottomSheet> {

  Widget storeItem(double width, globals.AwardsBadges shopItem) {
    return Container(
      width: 100,
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
                  child: Image.asset(
                    shopItem.imagePath,
                    height: 80,
                    fit: BoxFit.contain,
                  )
              ),
              SizedBox(height: 8.0),
              // Item name
              Text(
                shopItem.itemName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.darkBlack),
                textAlign: TextAlign.center,
              ),
            ],
          ),
      )
    );
  }

  Widget storeItems(double width, List eventList){
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: eventList.map((item){
        return storeItem(width, item);
      }).toList(),
    );
  }

  Widget regionGymAwards(String regionName, List eventList, double width){
    return Column(
      children: [
        Text(
          regionName,
          style: TextStyle(fontSize: 28, fontWeight:
          FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.none),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15,),
        storeItems(width, eventList)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_kanto,
                  (widget.showGym)?globals.kantoGym : globals.kantoContest,
                  width),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_johto,
                  (widget.showGym)?globals.johtoGym : globals.johtoContest,
                  width),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_hoenn,
                  (widget.showGym)?globals.hoennGym : globals.hoennContest,
                  width),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_sinnoh,
                  (widget.showGym)?globals.sinnohGym : globals.sinnohContest,
                  width),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_unova,
                  (widget.showGym)?globals.unovaGym : globals.unovaContest,
                  width),
              const SizedBox(height: 20,),
              regionGymAwards(
                  AppLocalizations.of(context)!.region_kalos,
                  (widget.showGym)?globals.kalosGym : globals.kalosContest,
                  width),
              const SizedBox(height: 20,)
            ],
          ),
        )
    );
  }
}