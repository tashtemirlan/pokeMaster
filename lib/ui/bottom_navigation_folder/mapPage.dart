import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokedexModel.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRegion.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../../models/pokemonFolder/pokeType.dart';
import '../../models/pokemonUser.dart';
import '../bottom_sheets_folder/poke_rullete_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bottom_sheets_folder/pokemon_pokedex_bottom_sheet.dart';
import '../global_folder/globals.dart';



class MapPage extends StatefulWidget{
  const MapPage({super.key});

  @override
  MapPageState createState ()=> MapPageState();

}

class MapPageState extends State<MapPage>{
  List<Pokemon> firstPokemonList = [];
  late Region selectedRegion;

  void viewPokeRouletteBottomSheet() async{
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return PokemonRouletteBottomSheet();
      },
    );
  }

  void showSettings(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          title: Text(
              AppLocalizations.of(context)!.settings_string, textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, color: colors.darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
              )
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{

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
                              AppLocalizations.of(context)!.settings_load_progress,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{

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
                              AppLocalizations.of(context)!.settings_save_progress,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> showRegions(BuildContext context) async{
    Region? selectedRegionDialog = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          title: Text(
              AppLocalizations.of(context)!.choose_region_string, textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, color: colors.darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
              )
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: listRegions.map((region) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async{
                            Navigator.of(context).pop(region);
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
                                showRegionPokemon(region, context),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                                )),
                          )
                      ),
                    )
                  );
                }).toList()
              ),
            )
          ],
        );
      },
    );

    if (selectedRegionDialog != null) {
      setState(() {
        selectedRegion = selectedRegionDialog;
      });
    }
  }

  void chooseFirstPokemon(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String choosenPokemon = "";
        return StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ),
                title: Text(
                  AppLocalizations.of(context)!.user_choose_first_pokemon_welcome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: colors.darkBlack,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.user_choose_first_pokemon_choose,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: colors.darkBlack,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Scrollable Grid of Pokémon Options
                    SizedBox(
                      height: 400,
                      width: double.maxFinite,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: firstPokemonList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          return pokeDexPokemon(
                              firstPokemonList[index].name,
                              firstPokemonList[index].type,
                              firstPokemonList[index].gifFront,
                              firstPokemonList[index].pokeDexIndex,
                              choosenPokemon,
                                (pokemonName) {
                              setState(() {
                                choosenPokemon = pokemonName;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                actionsPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async{
                            if(choosenPokemon.isNotEmpty){
                              for(int i=0; i<firstPokemonList.length; i++){
                                if(firstPokemonList[i].name == choosenPokemon){
                                  await registerFirstPokemon(firstPokemonList[i]);
                                  break;
                                }
                              }
                              Navigator.pop(context);
                            }
                          },
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              backgroundColor: (choosenPokemon.isNotEmpty)?
                              WidgetStateProperty.all<Color>(colors.searchBoxColor)
                                  :
                              WidgetStateProperty.all<Color>(colors.searchBoxColor.withOpacity(0.3))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                                AppLocalizations.of(context)!.user_choose_first_pokemon_button,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                                )),
                          )
                      ),
                    ),
                  ),
                ],
              );
            }
        );

      },
    );
  }

  Future<void> registerFirstPokemon(Pokemon pokemon) async{
    var box = await Hive.openBox("PokemonUserInventory");
    var box1 = await Hive.openBox("PokemonUserPokedex");

    List<dynamic> pokeListFromHiveDynamic = box.get("PokeUserInventory", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();

    List<dynamic> pokeListFromHiveDynamic1 = box1.get("Pokedex", defaultValue: []);
    List<PokedexPokemonModel> pokeListFromHive1 = pokeListFromHiveDynamic1.cast<PokedexPokemonModel>();

    //add pokemon to user collection =>
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    int minute = now.minute;
    int second = now.second;
    PokemonUser firstPokemon = PokemonUser(
        pokemon: pokemon,
        lvl: 1,
        hashId: "${year}_${month}_${day}_${minute}_${second}_${pokemon.name}"
    );
    pokeListFromHive.add(firstPokemon);
    await box.put("PokeUserInventory", pokeListFromHive);

    //set this pokemon found in pokedex =>
    for(int i=0; i<pokeListFromHive1.length; i++){
      if(pokeListFromHive1[i].pokemon == pokemon){
        pokeListFromHive1[i] = PokedexPokemonModel(pokemon: pokemon, isFound: true);
        break;
      }
    }
    await box1.put("Pokedex", pokeListFromHive1);
  }

  Widget pokeDexPokemon(
      String pokemonName,
      List<PokeType> types,
      String imagePath,
      int pokeInt,
      String selectedPokemon,
      Function(String) onSelect) {
    // Background color based on primary type
    Color backgroundColor = typeColors[types[0]] ?? Colors.grey;

    return GestureDetector(
      onTap: (){
        onSelect(pokemonName);
      },
      onLongPress: (){
        viewPokeBottomSheet(pokeInt);
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          border: (selectedPokemon == pokemonName)? Border.all(
            color: Colors.green.shade800,
            width: 3
          ) : null
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pokémon GIF
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            // Pokémon Name
            Text(
              showPokemonNameCyrillic(pokemonName),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void viewPokeBottomSheet(int pokeIndex) async{
    showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonPokedexBottomSheet(pokeIndex: pokeIndex, showFind: true, );
      },
    );
  }

  Future<void> checkUserHavePokemon(BuildContext context) async{
    var box = await Hive.openBox("PokemonUserInventory");
    List<dynamic> pokeListFromHiveDynamic = box.get("PokeUserInventory", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();
    if(pokeListFromHive.isEmpty){
      chooseFirstPokemon(context);
    }
  }

  Future<void> setDataFromHivePokedexInitialized() async{
    var box = await Hive.openBox("PokemonUserPokedex");
    List<dynamic> pokeListFromHiveDynamic = box.get("Pokemons", defaultValue: []);
    List<Pokemon> pokeListFromHive = pokeListFromHiveDynamic.cast<Pokemon>();

    firstPokemonList.add(pokeListFromHive[0]);
    firstPokemonList.add(pokeListFromHive[3]);
    firstPokemonList.add(pokeListFromHive[6]);

    firstPokemonList.add(pokeListFromHive[151]);
    firstPokemonList.add(pokeListFromHive[154]);
    firstPokemonList.add(pokeListFromHive[157]);

    firstPokemonList.add(pokeListFromHive[251]);
    firstPokemonList.add(pokeListFromHive[254]);
    firstPokemonList.add(pokeListFromHive[257]);

    firstPokemonList.add(pokeListFromHive[386]);
    firstPokemonList.add(pokeListFromHive[389]);
    firstPokemonList.add(pokeListFromHive[392]);

    firstPokemonList.add(pokeListFromHive[494]);
    firstPokemonList.add(pokeListFromHive[497]);
    firstPokemonList.add(pokeListFromHive[500]);
  }

  @override
  void initState() {
    super.initState();
    setDataFromHivePokedexInitialized();
    checkUserHavePokemon(context);
    selectedRegion = Region.Kanto;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double mainSizedBoxHeightUserNotLogged = height  - statusBarHeight - 80;
    return PopScope(
        canPop: false,
        child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Container(
                  width: width,
                  height: mainSizedBoxHeightUserNotLogged,
                  color: colors.scaffoldColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15,),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    viewPokeRouletteBottomSheet();
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
                                      child: Icon(Icons.catching_pokemon_outlined, color: Colors.white, size: 36,),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    showSettings(context);
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
                                      child: Icon(Icons.settings, color: Colors.white, size: 36,),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showRegions(context);
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
                                    child: Icon(Icons.public, color: Colors.white, size: 36,),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                  showRegionPokemon(selectedRegion, context),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24, color: colors.darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                                  )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              ),
            )
        )
    );
  }

}