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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    //Navigator.of(context).pushReplacement(MaterialPageRoute(
    //    builder: (BuildContext context) => const BottomNavBarScreen(positionBottomNavigationBar: 0,))
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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double mainHeight = height - statusBarHeight;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(56, 102, 65, 1)
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Разработано" ,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300 ,
                      fontFamily: 'Monteregular'
                  )
              ),
            ],
          ),
        )
    );
  }
}