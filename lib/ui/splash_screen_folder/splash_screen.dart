import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokemonmap/models/pokeAwards.dart';
import 'package:pokemonmap/models/pokedexModel.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRarity.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRegion.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeStats.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeType.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';

import 'package:pokemonmap/database_instructions/pokeNames.dart' as pokeNames;
import 'package:pokemonmap/database_instructions/pokeRarity.dart' as pokeRarity;
import 'package:pokemonmap/database_instructions/pokeRegion.dart' as pokeRegion;
import 'package:pokemonmap/database_instructions/pokeStats.dart' as pokeStats;
import 'package:pokemonmap/database_instructions/pokeTypes.dart' as pokeTypes;
import 'package:pokemonmap/database_instructions/pokeWeakness.dart' as pokeWeakness;

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/pokemonUser.dart';
import '../bottom_navigation_folder/bottomNavBar.dart';
import '../global_folder/globals.dart';


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
      await createUserData();
    }
    else{
      setUserPokeData();
    }
  }

  Future<bool> checkPokeUserDataBase() async{
    var box = await Hive.openBox("PokemonUserDataBase");
    bool initialized = box.containsKey("initialized");
    if(initialized){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> createUserData() async{
    log("fill poke user data");
    await createUserDataPokedex();
    await createUserDataCurrency();
    await createUserDataInventory();
    await createUserDataChallenge();
    await createUserDataContest();
    //we need to set that user data is initialized
    var box = await Hive.openBox("PokemonUserDataBase");
    box.put("initialized", true);
  }

  Future<void> createUserDataPokedex() async{
    log("fill poke user pokedex");
    List<PokedexPokemonModel> userPokedex = [];
    List<Pokemon> pokemonList = [];
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
          type: pokeTypes.pokePokeType[pokeInt],
          pokeStats: pokeStats.pokeStats[pokeInt],
          region: pokeRegion.pokeRegion[pokeInt],
          weakness: pokeWeakness.pokeWeakness[pokeInt],
          gifFront: gifFrontPath,
          gifBack: gifBackPath
      );
      PokedexPokemonModel pkm = PokedexPokemonModel(pokemon: poke, isFound: false);
      userPokedex.add(pkm);
      pokemonList.add(poke);
    }
    //Todo we need to write to our hive box data for user pokedex :
    var box = await Hive.openBox("PokemonUserPokedex");
    box.put("Pokedex", userPokedex);
    box.put("Pokemons", pokemonList);
  }

  Future<void> createUserDataCurrency() async{
    log("fill poke user currency");
    //todo : we will fill our data of currency gold:
    int currencyGold = 50000;
    var box = await Hive.openBox("PokemonUserDataBase");
    box.put("UserMoneys", currencyGold);
  }

  Future<void> createUserDataInventory() async{
    log("fill poke user inventory");
    //todo : we will fill our data of inventory
    // todo : pokemons :
    List<PokemonUser> pokeUserList = [];
    //todo : pokeballs
    // todo : Pokeball
    // todo : Great Ball
    // todo : Ultra Ball
    // todo : Master Ball:
    List<int> pokeballs = [10,1,0,0];
    var box = await Hive.openBox("PokemonUserInventory");
    box.put("PokeUserInventory", pokeUserList);
    box.put("PokeballsUserInventory", pokeballs);
  }

  Future<void> createUserDataChallenge() async{
    log("fill poke user data challenge");
    List<PokeAwards> challengePokeAwardsKanto = [];
    List<PokeAwards> challengePokeAwardsJohto = [];
    List<PokeAwards> challengePokeAwardsHoenn = [];
    List<PokeAwards> challengePokeAwardsSinho = [];
    List<PokeAwards> challengePokeAwardsUnova = [];
    List<PokeAwards> challengePokeAwardsKalos = [];
    List<List<PokeAwards>> mainList = [];

    //Kanto
    PokeAwards pokeAwards_k_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/k1.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k1_ch_string,
        cityName: AppLocalizations.of(context)!.k1_city_string);
    PokeAwards pokeAwards_k_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/k2.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k2_ch_string,
        cityName: AppLocalizations.of(context)!.k2_city_string);
    PokeAwards pokeAwards_k_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/k3.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k3_ch_string,
        cityName: AppLocalizations.of(context)!.k3_city_string);
    PokeAwards pokeAwards_k_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/k4.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k4_ch_string,
        cityName: AppLocalizations.of(context)!.k4_city_string);
    PokeAwards pokeAwards_k_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/k5.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k5_ch_string,
        cityName: AppLocalizations.of(context)!.k5_city_string);
    PokeAwards pokeAwards_k_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/k6.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k6_ch_string,
        cityName: AppLocalizations.of(context)!.k6_city_string);
    PokeAwards pokeAwards_k_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/k7.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k7_ch_string,
        cityName: AppLocalizations.of(context)!.k7_city_string);
    PokeAwards pokeAwards_k_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/k8.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.k8_ch_string,
        cityName: AppLocalizations.of(context)!.k8_city_string);

    //Johto
    PokeAwards pokeAwards_j_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/j1.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j1_ch_string,
        cityName: AppLocalizations.of(context)!.j1_city_string);
    PokeAwards pokeAwards_j_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/j2.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j2_ch_string,
        cityName: AppLocalizations.of(context)!.j2_city_string);
    PokeAwards pokeAwards_j_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/j3.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j3_ch_string,
        cityName: AppLocalizations.of(context)!.j3_city_string);
    PokeAwards pokeAwards_j_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/j4.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j4_ch_string,
        cityName: AppLocalizations.of(context)!.j4_city_string);
    PokeAwards pokeAwards_j_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/j5.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j5_ch_string,
        cityName: AppLocalizations.of(context)!.j5_city_string);
    PokeAwards pokeAwards_j_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/j6.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j6_ch_string,
        cityName: AppLocalizations.of(context)!.j6_city_string);
    PokeAwards pokeAwards_j_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/j7.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j7_ch_string,
        cityName: AppLocalizations.of(context)!.j7_city_string);
    PokeAwards pokeAwards_j_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/j8.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.j8_ch_string,
        cityName: AppLocalizations.of(context)!.j8_city_string);

    //Hoenn
    PokeAwards pokeAwards_h_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/h1.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h1_ch_string,
        cityName: AppLocalizations.of(context)!.h1_city_string);
    PokeAwards pokeAwards_h_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/h2.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h2_ch_string,
        cityName: AppLocalizations.of(context)!.h2_city_string);
    PokeAwards pokeAwards_h_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/h3.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h3_ch_string,
        cityName: AppLocalizations.of(context)!.h3_city_string);
    PokeAwards pokeAwards_h_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/h4.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h4_ch_string,
        cityName: AppLocalizations.of(context)!.h4_city_string);
    PokeAwards pokeAwards_h_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/h5.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h5_ch_string,
        cityName: AppLocalizations.of(context)!.h5_city_string);
    PokeAwards pokeAwards_h_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/h6.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h6_ch_string,
        cityName: AppLocalizations.of(context)!.h6_city_string);
    PokeAwards pokeAwards_h_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/h7.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h7_ch_string,
        cityName: AppLocalizations.of(context)!.h7_city_string);
    PokeAwards pokeAwards_h_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/h8.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.h8_ch_string,
        cityName: AppLocalizations.of(context)!.h8_city_string);

    //Sinho
    PokeAwards pokeAwards_s_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/s1.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s1_ch_string,
        cityName: AppLocalizations.of(context)!.s1_city_string);
    PokeAwards pokeAwards_s_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/s2.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s2_ch_string,
        cityName: AppLocalizations.of(context)!.s2_city_string);
    PokeAwards pokeAwards_s_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/s3.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s3_ch_string,
        cityName: AppLocalizations.of(context)!.s3_city_string);
    PokeAwards pokeAwards_s_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/s4.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s4_ch_string,
        cityName: AppLocalizations.of(context)!.s4_city_string);
    PokeAwards pokeAwards_s_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/s5.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s5_ch_string,
        cityName: AppLocalizations.of(context)!.s5_city_string);
    PokeAwards pokeAwards_s_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/s6.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s6_ch_string,
        cityName: AppLocalizations.of(context)!.s6_city_string);
    PokeAwards pokeAwards_s_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/s7.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s7_ch_string,
        cityName: AppLocalizations.of(context)!.s7_city_string);
    PokeAwards pokeAwards_s_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/s8.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.s8_ch_string,
        cityName: AppLocalizations.of(context)!.s8_city_string);

    //Unova
    PokeAwards pokeAwards_u_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/u1.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u1_ch_string,
        cityName: AppLocalizations.of(context)!.u1_city_string);
    PokeAwards pokeAwards_u_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/u2.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u2_ch_string,
        cityName: AppLocalizations.of(context)!.u2_city_string);
    PokeAwards pokeAwards_u_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/u3.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u3_ch_string,
        cityName: AppLocalizations.of(context)!.u3_city_string);
    PokeAwards pokeAwards_u_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/u4.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u4_ch_string,
        cityName: AppLocalizations.of(context)!.u4_city_string);
    PokeAwards pokeAwards_u_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/u5.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u5_ch_string,
        cityName: AppLocalizations.of(context)!.u5_city_string);
    PokeAwards pokeAwards_u_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/u6.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u6_ch_string,
        cityName: AppLocalizations.of(context)!.u6_city_string);
    PokeAwards pokeAwards_u_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/u7.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u7_ch_string,
        cityName: AppLocalizations.of(context)!.u7_city_string);
    PokeAwards pokeAwards_u_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/u8.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.u8_ch_string,
        cityName: AppLocalizations.of(context)!.u8_city_string);

    //Kalos
    PokeAwards pokeAwards_ka_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka1.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka1_ch_string,
        cityName: AppLocalizations.of(context)!.ka1_city_string);
    PokeAwards pokeAwards_ka_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka2.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka2_ch_string,
        cityName: AppLocalizations.of(context)!.ka2_city_string);
    PokeAwards pokeAwards_ka_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka3.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka3_ch_string,
        cityName:  AppLocalizations.of(context)!.ka3_city_string);
    PokeAwards pokeAwards_ka_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka4.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka4_ch_string,
        cityName:  AppLocalizations.of(context)!.ka4_city_string);
    PokeAwards pokeAwards_ka_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka5.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka5_ch_string,
        cityName:  AppLocalizations.of(context)!.ka5_city_string);
    PokeAwards pokeAwards_ka_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka6.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka6_ch_string,
        cityName:  AppLocalizations.of(context)!.ka6_city_string);
    PokeAwards pokeAwards_ka_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka7.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka7_ch_string,
        cityName:  AppLocalizations.of(context)!.ka7_city_string);
    PokeAwards pokeAwards_ka_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/ka8.png",
        obtained: false,
        awardName: AppLocalizations.of(context)!.ka8_ch_string,
        cityName:  AppLocalizations.of(context)!.ka8_city_string);

    challengePokeAwardsKanto.add(pokeAwards_k_1);
    challengePokeAwardsKanto.add(pokeAwards_k_2);
    challengePokeAwardsKanto.add(pokeAwards_k_3);
    challengePokeAwardsKanto.add(pokeAwards_k_4);
    challengePokeAwardsKanto.add(pokeAwards_k_5);
    challengePokeAwardsKanto.add(pokeAwards_k_6);
    challengePokeAwardsKanto.add(pokeAwards_k_7);
    challengePokeAwardsKanto.add(pokeAwards_k_8);

    challengePokeAwardsJohto.add(pokeAwards_j_1);
    challengePokeAwardsJohto.add(pokeAwards_j_2);
    challengePokeAwardsJohto.add(pokeAwards_j_3);
    challengePokeAwardsJohto.add(pokeAwards_j_4);
    challengePokeAwardsJohto.add(pokeAwards_j_5);
    challengePokeAwardsJohto.add(pokeAwards_j_6);
    challengePokeAwardsJohto.add(pokeAwards_j_7);
    challengePokeAwardsJohto.add(pokeAwards_j_8);

    challengePokeAwardsHoenn.add(pokeAwards_h_1);
    challengePokeAwardsHoenn.add(pokeAwards_h_2);
    challengePokeAwardsHoenn.add(pokeAwards_h_3);
    challengePokeAwardsHoenn.add(pokeAwards_h_4);
    challengePokeAwardsHoenn.add(pokeAwards_h_5);
    challengePokeAwardsHoenn.add(pokeAwards_h_6);
    challengePokeAwardsHoenn.add(pokeAwards_h_7);
    challengePokeAwardsHoenn.add(pokeAwards_h_8);

    challengePokeAwardsSinho.add(pokeAwards_s_1);
    challengePokeAwardsSinho.add(pokeAwards_s_2);
    challengePokeAwardsSinho.add(pokeAwards_s_3);
    challengePokeAwardsSinho.add(pokeAwards_s_4);
    challengePokeAwardsSinho.add(pokeAwards_s_5);
    challengePokeAwardsSinho.add(pokeAwards_s_6);
    challengePokeAwardsSinho.add(pokeAwards_s_7);
    challengePokeAwardsSinho.add(pokeAwards_s_8);

    challengePokeAwardsUnova.add(pokeAwards_u_1);
    challengePokeAwardsUnova.add(pokeAwards_u_2);
    challengePokeAwardsUnova.add(pokeAwards_u_3);
    challengePokeAwardsUnova.add(pokeAwards_u_4);
    challengePokeAwardsUnova.add(pokeAwards_u_5);
    challengePokeAwardsUnova.add(pokeAwards_u_6);
    challengePokeAwardsUnova.add(pokeAwards_u_7);
    challengePokeAwardsUnova.add(pokeAwards_u_8);

    challengePokeAwardsKalos.add(pokeAwards_ka_1);
    challengePokeAwardsKalos.add(pokeAwards_ka_2);
    challengePokeAwardsKalos.add(pokeAwards_ka_3);
    challengePokeAwardsKalos.add(pokeAwards_ka_4);
    challengePokeAwardsKalos.add(pokeAwards_ka_5);
    challengePokeAwardsKalos.add(pokeAwards_ka_6);
    challengePokeAwardsKalos.add(pokeAwards_ka_7);
    challengePokeAwardsKalos.add(pokeAwards_ka_8);

    mainList.add(challengePokeAwardsKanto);
    mainList.add(challengePokeAwardsJohto);
    mainList.add(challengePokeAwardsHoenn);
    mainList.add(challengePokeAwardsSinho);
    mainList.add(challengePokeAwardsUnova);
    mainList.add(challengePokeAwardsKalos);


    //Todo we need to write to our hive box data for user poke awards challenge :
    var box = await Hive.openBox("PokemonUserDataBase");
    box.put("PokeChallenge", mainList);
  }

  Future<void> createUserDataContest() async{
    log("fill poke user data contest");
    //todo : name awards like Ribbon - city name (Лента города палет таун)
    List<PokeAwards> contestPokeAwardsKanto = [];
    List<PokeAwards> contestPokeAwardsJohto = [];
    List<PokeAwards> contestPokeAwardsHoenn = [];
    List<PokeAwards> contestPokeAwardsSinho = [];
    List<PokeAwards> contestPokeAwardsUnova = [];
    List<PokeAwards> contestPokeAwardsKalos = [];
    List<List<PokeAwards>> mainList = [];

    //Kanto
    PokeAwards pokeAwards_k_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k1_city_string}",
        cityName: AppLocalizations.of(context)!.k1_city_string);
    PokeAwards pokeAwards_k_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k2_city_string}",
        cityName: AppLocalizations.of(context)!.k2_city_string);
    PokeAwards pokeAwards_k_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k3_city_string}",
        cityName: AppLocalizations.of(context)!.k3_city_string);
    PokeAwards pokeAwards_k_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k4_city_string}",
        cityName: AppLocalizations.of(context)!.k4_city_string);
    PokeAwards pokeAwards_k_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k5_city_string}",
        cityName: AppLocalizations.of(context)!.k5_city_string);
    PokeAwards pokeAwards_k_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k6_city_string}",
        cityName: AppLocalizations.of(context)!.k6_city_string);
    PokeAwards pokeAwards_k_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k7_city_string}",
        cityName: AppLocalizations.of(context)!.k7_city_string);
    PokeAwards pokeAwards_k_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.k8_city_string}",
        cityName: AppLocalizations.of(context)!.k8_city_string);

    //Johto
    PokeAwards pokeAwards_j_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j1_city_string}",
        cityName: AppLocalizations.of(context)!.j1_city_string);
    PokeAwards pokeAwards_j_2 = PokeAwards(
        awardImagePath:"assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j2_city_string}",
        cityName: AppLocalizations.of(context)!.j2_city_string);
    PokeAwards pokeAwards_j_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j3_city_string}",
        cityName: AppLocalizations.of(context)!.j3_city_string);
    PokeAwards pokeAwards_j_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j4_city_string}",
        cityName: AppLocalizations.of(context)!.j4_city_string);
    PokeAwards pokeAwards_j_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j5_city_string}",
        cityName: AppLocalizations.of(context)!.j5_city_string);
    PokeAwards pokeAwards_j_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j6_city_string}",
        cityName: AppLocalizations.of(context)!.j6_city_string);
    PokeAwards pokeAwards_j_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j7_city_string}",
        cityName: AppLocalizations.of(context)!.j7_city_string);
    PokeAwards pokeAwards_j_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.j8_city_string}",
        cityName: AppLocalizations.of(context)!.j8_city_string);

    //Hoenn
    PokeAwards pokeAwards_h_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h1_city_string}",
        cityName: AppLocalizations.of(context)!.h1_city_string);
    PokeAwards pokeAwards_h_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h2_city_string}",
        cityName: AppLocalizations.of(context)!.h2_city_string);
    PokeAwards pokeAwards_h_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h3_city_string}",
        cityName: AppLocalizations.of(context)!.h3_city_string);
    PokeAwards pokeAwards_h_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h4_city_string}",
        cityName: AppLocalizations.of(context)!.h4_city_string);
    PokeAwards pokeAwards_h_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h5_city_string}",
        cityName: AppLocalizations.of(context)!.h5_city_string);
    PokeAwards pokeAwards_h_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h6_city_string}",
        cityName: AppLocalizations.of(context)!.h6_city_string);
    PokeAwards pokeAwards_h_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h7_city_string}",
        cityName: AppLocalizations.of(context)!.h7_city_string);
    PokeAwards pokeAwards_h_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.h8_city_string}",
        cityName: AppLocalizations.of(context)!.h8_city_string);

    //Sinho
    PokeAwards pokeAwards_s_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s1_city_string}",
        cityName: AppLocalizations.of(context)!.s1_city_string);
    PokeAwards pokeAwards_s_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s2_city_string}",
        cityName: AppLocalizations.of(context)!.s2_city_string);
    PokeAwards pokeAwards_s_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s3_city_string}",
        cityName: AppLocalizations.of(context)!.s3_city_string);
    PokeAwards pokeAwards_s_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s4_city_string}",
        cityName: AppLocalizations.of(context)!.s4_city_string);
    PokeAwards pokeAwards_s_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s5_city_string}",
        cityName: AppLocalizations.of(context)!.s5_city_string);
    PokeAwards pokeAwards_s_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s6_city_string}",
        cityName: AppLocalizations.of(context)!.s6_city_string);
    PokeAwards pokeAwards_s_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s7_city_string}",
        cityName: AppLocalizations.of(context)!.s7_city_string);
    PokeAwards pokeAwards_s_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.s8_city_string}",
        cityName: AppLocalizations.of(context)!.s8_city_string);

    //Unova
    PokeAwards pokeAwards_u_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u1_city_string}",
        cityName: AppLocalizations.of(context)!.u1_city_string);
    PokeAwards pokeAwards_u_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u2_city_string}",
        cityName: AppLocalizations.of(context)!.u2_city_string);
    PokeAwards pokeAwards_u_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u3_city_string}",
        cityName: AppLocalizations.of(context)!.u3_city_string);
    PokeAwards pokeAwards_u_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u4_city_string}",
        cityName: AppLocalizations.of(context)!.u4_city_string);
    PokeAwards pokeAwards_u_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u5_city_string}",
        cityName: AppLocalizations.of(context)!.u5_city_string);
    PokeAwards pokeAwards_u_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u6_city_string}",
        cityName: AppLocalizations.of(context)!.u6_city_string);
    PokeAwards pokeAwards_u_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u7_city_string}",
        cityName: AppLocalizations.of(context)!.u7_city_string);
    PokeAwards pokeAwards_u_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.u8_city_string}",
        cityName: AppLocalizations.of(context)!.u8_city_string);

    //Kalos
    PokeAwards pokeAwards_ka_1 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka1_city_string}",
        cityName: AppLocalizations.of(context)!.ka1_city_string);
    PokeAwards pokeAwards_ka_2 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka2_city_string}",
        cityName: AppLocalizations.of(context)!.ka2_city_string);
    PokeAwards pokeAwards_ka_3 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka3_city_string}",
        cityName:  AppLocalizations.of(context)!.ka3_city_string);
    PokeAwards pokeAwards_ka_4 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka4_city_string}",
        cityName:  AppLocalizations.of(context)!.ka4_city_string);
    PokeAwards pokeAwards_ka_5 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName:"${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka5_city_string}",
        cityName:  AppLocalizations.of(context)!.ka5_city_string);
    PokeAwards pokeAwards_ka_6 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka6_city_string}",
        cityName:  AppLocalizations.of(context)!.ka6_city_string);
    PokeAwards pokeAwards_ka_7 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka7_city_string}",
        cityName:  AppLocalizations.of(context)!.ka7_city_string);
    PokeAwards pokeAwards_ka_8 = PokeAwards(
        awardImagePath: "assets/pokeimages/contestaward.png",
        obtained: false,
        awardName: "${AppLocalizations.of(context)!.ribbon_string} ${AppLocalizations.of(context)!.ka8_city_string}",
        cityName:  AppLocalizations.of(context)!.ka8_city_string);

    contestPokeAwardsKanto.add(pokeAwards_k_1);
    contestPokeAwardsKanto.add(pokeAwards_k_2);
    contestPokeAwardsKanto.add(pokeAwards_k_3);
    contestPokeAwardsKanto.add(pokeAwards_k_4);
    contestPokeAwardsKanto.add(pokeAwards_k_5);
    contestPokeAwardsKanto.add(pokeAwards_k_6);
    contestPokeAwardsKanto.add(pokeAwards_k_7);
    contestPokeAwardsKanto.add(pokeAwards_k_8);

    contestPokeAwardsJohto.add(pokeAwards_j_1);
    contestPokeAwardsJohto.add(pokeAwards_j_2);
    contestPokeAwardsJohto.add(pokeAwards_j_3);
    contestPokeAwardsJohto.add(pokeAwards_j_4);
    contestPokeAwardsJohto.add(pokeAwards_j_5);
    contestPokeAwardsJohto.add(pokeAwards_j_6);
    contestPokeAwardsJohto.add(pokeAwards_j_7);
    contestPokeAwardsJohto.add(pokeAwards_j_8);

    contestPokeAwardsHoenn.add(pokeAwards_h_1);
    contestPokeAwardsHoenn.add(pokeAwards_h_2);
    contestPokeAwardsHoenn.add(pokeAwards_h_3);
    contestPokeAwardsHoenn.add(pokeAwards_h_4);
    contestPokeAwardsHoenn.add(pokeAwards_h_5);
    contestPokeAwardsHoenn.add(pokeAwards_h_6);
    contestPokeAwardsHoenn.add(pokeAwards_h_7);
    contestPokeAwardsHoenn.add(pokeAwards_h_8);

    contestPokeAwardsSinho.add(pokeAwards_s_1);
    contestPokeAwardsSinho.add(pokeAwards_s_2);
    contestPokeAwardsSinho.add(pokeAwards_s_3);
    contestPokeAwardsSinho.add(pokeAwards_s_4);
    contestPokeAwardsSinho.add(pokeAwards_s_5);
    contestPokeAwardsSinho.add(pokeAwards_s_6);
    contestPokeAwardsSinho.add(pokeAwards_s_7);
    contestPokeAwardsSinho.add(pokeAwards_s_8);

    contestPokeAwardsUnova.add(pokeAwards_u_1);
    contestPokeAwardsUnova.add(pokeAwards_u_2);
    contestPokeAwardsUnova.add(pokeAwards_u_3);
    contestPokeAwardsUnova.add(pokeAwards_u_4);
    contestPokeAwardsUnova.add(pokeAwards_u_5);
    contestPokeAwardsUnova.add(pokeAwards_u_6);
    contestPokeAwardsUnova.add(pokeAwards_u_7);
    contestPokeAwardsUnova.add(pokeAwards_u_8);

    contestPokeAwardsKalos.add(pokeAwards_ka_1);
    contestPokeAwardsKalos.add(pokeAwards_ka_2);
    contestPokeAwardsKalos.add(pokeAwards_ka_3);
    contestPokeAwardsKalos.add(pokeAwards_ka_4);
    contestPokeAwardsKalos.add(pokeAwards_ka_5);
    contestPokeAwardsKalos.add(pokeAwards_ka_6);
    contestPokeAwardsKalos.add(pokeAwards_ka_7);
    contestPokeAwardsKalos.add(pokeAwards_ka_8);

    mainList.add(contestPokeAwardsKanto);
    mainList.add(contestPokeAwardsJohto);
    mainList.add(contestPokeAwardsHoenn);
    mainList.add(contestPokeAwardsSinho);
    mainList.add(contestPokeAwardsUnova);
    mainList.add(contestPokeAwardsKalos);


    //Todo we need to write to our hive box data for user poke awards challenge :
    var box = await Hive.openBox("PokemonUserDataBase");
    box.put("PokeContest", mainList);
  }

  Future<void> setUserPokeData() async{
    log("set user poke data");
    //we should define allpokemons = =>
    setAllPokemonsGlobal();
  }

  Future<void> setAllPokemonsGlobal() async{
    //To do : here we need to set data to globals pokemons :
    var box = await Hive.openBox("PokemonUserPokedex");
    List<dynamic> pokeListFromHiveDynamic = box.get("Pokemons", defaultValue: []);
    List<Pokemon> pokeListFromHive = pokeListFromHiveDynamic.cast<Pokemon>();
    pokemonsAllList = pokeListFromHive;
  }

  Future<void> registerHiveAdapters() async{
    Hive.registerAdapter(PokedexPokemonModelAdapter());
    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(PokeStatsAdapter());
    Hive.registerAdapter(RegionAdapter());
    Hive.registerAdapter(RarityAdapter());
    Hive.registerAdapter(PokeTypeAdapter());
    Hive.registerAdapter(PokeAwardsAdapter());
    Hive.registerAdapter(PokemonUserAdapter());

  }

  Future<void> logoMainMethod() async{
    //todo: ensure to initialize all neccessary voids and methods =>
    await Hive.initFlutter();
    //todo : register adapter =>
    await registerHiveAdapters();
    // todo : check poke data =>
    await checkPokeData();
    //todo : navigate to our app =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => const BottomPokeNavigationBar(),
    ));
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