import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/pokeAwards.dart';
import '../bottom_sheets_folder/poke_badges_bottom_sheet.dart';

class ContestTab extends StatefulWidget {
  @override
  _ContestTabState createState() => _ContestTabState();
}

class _ContestTabState extends State<ContestTab> {

  bool dataGet = false;
  List<List<PokeAwards>> hiveList = [];

  void showAllContestAwards(){
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return PokeBadgesBottomSheet(
          showGym: false,
        );
      },
    );
  }

  Future<void> setDataFromHivePokedexInitialized() async {
    var box = await Hive.openBox("PokemonUserDataBase");
    List<dynamic> pokeListAwards = box.get("PokeContest", defaultValue: []);
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

  Widget locationListContestKanto(List<PokeAwards> pokeAwardsList) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
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
                      Icon(FontAwesomeIcons.ribbon, color: Colors.white, size: 36,)
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

  Widget locationListContestJohto(List<PokeAwards> pokeAwardsList) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
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
                      Icon(FontAwesomeIcons.ribbon, color: Colors.white, size: 36,)
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

  Widget locationListContestHoenn(List<PokeAwards> pokeAwardsList) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
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
                      Icon(FontAwesomeIcons.ribbon, color: Colors.white, size: 36,)
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

  Widget locationListContestSinnoh(List<PokeAwards> pokeAwardsList) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
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
                      Icon(FontAwesomeIcons.ribbon, color: Colors.white, size: 36,)
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

  Widget locationListContestUnova(List<PokeAwards> pokeAwardsList) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
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
                      Icon(FontAwesomeIcons.ribbon, color: Colors.white, size: 36,)
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

  Widget locationListContestKalos(List<PokeAwards> pokeAwardsList) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(8, (index) {
        return Align(
          alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: GestureDetector(
            onTap: (){
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
                      Icon(FontAwesomeIcons.ribbon, color: Colors.white, size: 36,)
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

  Widget locationBigFestivalKanto(){
    return GestureDetector(
      onTap: (){

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
                  "${AppLocalizations.of(context)!.big_festival_string} ${AppLocalizations.of(context)!.region_kanto}",
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

  Widget locationBigFestivalJhoto(){
    return GestureDetector(
      onTap: (){

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
                  "${AppLocalizations.of(context)!.big_festival_string} ${AppLocalizations.of(context)!.region_johto}",
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

  Widget locationBigFestivalHoenn(){
    return GestureDetector(
      onTap: (){

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
                  "${AppLocalizations.of(context)!.big_festival_string} ${AppLocalizations.of(context)!.region_hoenn}",
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

  Widget locationBigFestivalSinnoh(){
    return GestureDetector(
      onTap: (){

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
                  "${AppLocalizations.of(context)!.big_festival_string} ${AppLocalizations.of(context)!.region_sinnoh}",
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

  Widget locationBigFestivalUnova(){
    return GestureDetector(
      onTap: (){

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
                  "${AppLocalizations.of(context)!.big_festival_string} ${AppLocalizations.of(context)!.region_unova}",
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

  Widget locationBigFestivalKalos(){
    return GestureDetector(
      onTap: (){

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
                  "${AppLocalizations.of(context)!.big_festival_string} ${AppLocalizations.of(context)!.region_kalos}",
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
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                      showAllContestAwards();
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
                        child: Icon(FontAwesomeIcons.award, color: Colors.white, size: 32,),
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
              locationListContestKanto(hiveList[0]),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationBigFestivalKanto(),
              const SizedBox(height: 10,),
              //Jhoto
              Text(AppLocalizations.of(context)!.region_johto,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,
                    color: colors.darkBlack, decoration: TextDecoration.underline), textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListContestJohto(hiveList[1]),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationBigFestivalJhoto(),
              const SizedBox(height: 10,),
              //Hoenn
              Text(
                AppLocalizations.of(context)!.region_hoenn,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListContestHoenn(hiveList[2]),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationBigFestivalHoenn(),
              const SizedBox(height: 10,),
              //Sinnoh
              Text(
                AppLocalizations.of(context)!.region_sinnoh,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListContestSinnoh(hiveList[3]),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationBigFestivalSinnoh(),
              const SizedBox(height: 10,),
              //Unova
              Text(
                AppLocalizations.of(context)!.region_unova,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListContestUnova(hiveList[4]),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationBigFestivalUnova(),
              const SizedBox(height: 10,),
              //Kalos
              Text(
                AppLocalizations.of(context)!.region_kalos,
                style: TextStyle(fontSize: 32, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              locationListContestKalos(hiveList[5]),
              const SizedBox(height: 20,),
              //we can't fight against master untill we beat all elite 4 members
              locationBigFestivalKalos(),
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