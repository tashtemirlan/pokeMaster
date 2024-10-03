import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokemonmap/Models/pokemonModel.dart';

import 'package:pokemonmap/DatabaseInstructions/pokeNames.dart' as pokeNames;
import 'package:pokemonmap/DatabaseInstructions/pokeGifs.dart' as pokeGifs;
import 'package:pokemonmap/DatabaseInstructions/pokeRarity.dart' as pokeRarity;
import 'package:pokemonmap/DatabaseInstructions/pokeRegion.dart' as pokeRegion;
import 'package:pokemonmap/DatabaseInstructions/pokeStats.dart' as pokeStats;
import 'package:pokemonmap/DatabaseInstructions/pokeTypes.dart' as pokeTypes;
import 'package:pokemonmap/DatabaseInstructions/pokeWeakness.dart' as pokeWeakness;
import 'package:pokemonmap/UI/GlobalFolder/colors.dart' as colors;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../BottomNavigationFolder/bottomNavBar.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  SplashScreenState createState ()=> SplashScreenState();

}

class SplashScreenState extends State<SplashScreen>{
  String noInternetRu = "Нет подключения\nк интернету!";
  String noInternetKg = "Интернетке байланыш жок";

  double opacityLogo = 0;

  double allPokemonVal = 10;
  List<Pokemon> pokemonList = [];

  Future<bool> checkPokeDataBase() async{
    var box = await Hive.openBox("PokemonDataBaseInitialized");
    bool initialized = box.containsKey("initialized");
    if(initialized){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> checkPokeData() async{
    bool pokeDataBaseInitialized = await checkPokeDataBase();
    print(pokeDataBaseInitialized);
    if(!pokeDataBaseInitialized){
      await fillHivePokeDataBase();
    }
  }

  Future<void> fillHivePokeDataBase() async{
    for(int pokeInt = 0; pokeInt< pokeNames.pokeNames.length;pokeInt++ ){
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