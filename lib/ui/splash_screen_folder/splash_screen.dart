import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokemonmap/models/pokedexModel.dart';
import 'package:pokemonmap/models/pokemonModel.dart';

import 'package:pokemonmap/database_instructions/pokeNames.dart' as pokeNames;
import 'package:pokemonmap/database_instructions/pokeRarity.dart' as pokeRarity;
import 'package:pokemonmap/database_instructions/pokeRegion.dart' as pokeRegion;
import 'package:pokemonmap/database_instructions/pokeStats.dart' as pokeStats;
import 'package:pokemonmap/database_instructions/pokeTypes.dart' as pokeTypes;
import 'package:pokemonmap/database_instructions/pokeWeakness.dart' as pokeWeakness;
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bottom_navigation_folder/bottomNavBar.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  SplashScreenState createState ()=> SplashScreenState();

}

class SplashScreenState extends State<SplashScreen>{
  List<Pokemon> pokemonList = [];

  Future<void> checkPokeData() async{
    bool pokeUserInitialized = await checkPokeUserDataBase();
    if(pokeUserInitialized == false){
      await fillHivePokeDataBase();
    }
    else{
      setUserPokeData();
    }
  }

  Future<bool> checkPokeUserDataBase() async{
    var box = await Hive.openBox("PokemonUserDataBaseInitialized");
    bool initialized = box.containsKey("initialized");
    if(initialized){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> fillHivePokeDataBase() async{
    log("fill poke user data");
  }

  Future<void> setUserPokeData() async{
    log("set user poke data");
  }

  Future<void> fillPokemons() async{
    List<PokedexPokemonModel> userPokedex = [];
    for(int pokeInt = 0; pokeInt< pokeNames.pokeNames.length; pokeInt++ ){
      String gifFrontPath = "";
      String gifBackPath = "";
      if(pokeInt<99){
        if(pokeInt<9){
          gifFrontPath = 'assets/gifs/00${pokeInt + 1}.gif';
          gifBackPath = 'assets/gifs/00${pokeInt + 1}b.gif';
        }
        else{
          gifFrontPath = 'assets/gifs/0${pokeInt + 1}.gif';
          gifBackPath = 'assets/gifs/0${pokeInt + 1}b.gif';
        }
      }
      else{
        gifFrontPath = 'assets/gifs/${pokeInt + 1}.gif';
        gifBackPath = 'assets/gifs/${pokeInt + 1}b.gif';
      }
      Pokemon poke = Pokemon(
          pokeDexIndex: pokeInt,
          name: pokeNames.pokeNames[pokeInt],
          rarity: pokeRarity.pokeRarity[pokeInt],
          type: pokeTypes.pokeType[pokeInt],
          pokeStats: pokeStats.pokeStats[pokeInt],
          region: pokeRegion.pokeRegion[pokeInt],
          weakness: pokeWeakness.pokeWeakness[pokeInt],
          gifFront: gifFrontPath,
          gifBack: gifBackPath
      );
      PokedexPokemonModel pkm = PokedexPokemonModel(pokemon: poke, isFound: false);
      userPokedex.add(pkm);
      globals.listAllPokemons.add(poke);
    }
  }

  Future<void> showWelcomeMessage() async{
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context)!.welcomeMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 12.0,
    );
  }

  Future<void> logoMainMethod() async{
    //todo: ensure to initialize all neccessary voids and methods =>
    await Hive.initFlutter();
    // todo : check poke data =>
    await checkPokeData();
    // todo : show welcome message =>
    await showWelcomeMessage();
    //todo : navigate to our app =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const BottomPokeNavigationBar()));
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    logoMainMethod();
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width,
          height: height,
          color: colors.scaffoldColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height*0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/gifs/350.gif",
                      width: width*0.75,
                      height: width*0.75,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(height: 15,),
                    Text(
                        "PokeMap\n   dev. by TeitCorp" ,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600,
                        )
                    ),
                  ],
                )
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Text(
                            "Pokémon images & names \n© 1995-2024 Nintendo/Game Freak." ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12, color: Colors.black, fontWeight: FontWeight.w600,
                            )
                        ),
                    ),
                  )
              )
            ],
          ),
        )
    );
  }
}