import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeStats.dart';
import 'package:pokemonmap/models/pokemonWildModel.dart';
import 'package:hive/hive.dart';
import 'package:pokemonmap/models/pokemonUser.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart';
import 'package:pokemonmap/ui/global_folder/evolution_folder/experience_data_list.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/pokedexModel.dart';
import '../../models/pokemonFolder/pokeRarity.dart';
import '../../models/pokemonFolder/pokemonModel.dart';


enum PokeballsTypeCatch{
  Pokeball,
  Greatball,
  Ultraball,
  Masterball
}

enum PokeAction{
  Attack,
  ElemtalAttack,
  Defence,
  ElemtalDefence,
  Capture
}

class BattleBottomSheetScreen extends StatefulWidget {
  final List<PokemonWild> pokeWildList;

  const BattleBottomSheetScreen({super.key, required this.pokeWildList});

  @override
  BattleBottomSheetScreenState createState() => BattleBottomSheetScreenState();
}

class BattleBottomSheetScreenState extends State<BattleBottomSheetScreen> with TickerProviderStateMixin  {
  List<PokemonUser?> userTeam = List.filled(6, null, growable: false);
  bool dataGet = false;
  late PokemonUser currentUserPokemon;
  late PokemonWild currentWildPokemon;
  final Random _random = Random();
  final Random _randomPokeActions = Random();
  final Random _randomCatchProbability = Random();
  int randomVal = 0;
  late PokeballsTypeCatch selectedPokeball;
  List<int> userPokeBalls = [];
  int selectedIndex = 0;

  List<PokedexPokemonModel> hivePokedexList = [];

  int expNeedToNextLvl = 0;
  int currentExpPokemonUser = 0;

  double userSelectedPokemonMaxHp = 0;
  double wildSelectedPokemonMaxHp = 0;
  double currentHpPokemonUser = 0;
  double currentHpPokemonWild = 0;

  double addedShieldCasualUserPokemon =0;
  double addedShieldElementalUserPokemon =0;

  double addedShieldCasualWildPokemon = 0;
  double addedShieldElementalWildPokemon = 0;


  String textLastMove = "";
  String allLogText = "";

  int showUserMoney = 0;

  late AnimationController controllerAnimationUser;
  late AnimationController controllerAnimationWild;

  late Animation<Offset> animationImageUser;
  bool animatingImageUser = false;

  late Animation<Offset> animationWildPokemon;
  bool animatingWildPokemon = false;


  final GlobalKey gifKeyImageUser = GlobalKey();
  final GlobalKey gifKeyImageWild = GlobalKey();

  List<String> defeatedUserPokemons = [];

  double userBasicHp = 0;
  double userBasicAttack = 0;
  double userBasicDefence = 0;
  double userBasicSpAttack = 0;
  double userBasicSpDefence = 0;
  double userBasicSpeed = 0;

  double userUpgradedHp = 0;
  double userUpgradedAttack = 0;
  double userUpgradedDefence = 0;
  double userUpgradedSpAttack = 0;
  double userUpgradedSpDefence = 0;
  double userUpgradedSpeed = 0;

  double wildBasicHp = 0;
  double wildBasicAttack = 0;
  double wildBasicDefence = 0;
  double wildBasicSpAttack = 0;
  double wildBasicSpDefence = 0;
  double wildBasicSpeed = 0;

  double wildUpgradedHp = 0;
  double wildUpgradedAttack = 0;
  double wildUpgradedDefence = 0;
  double wildUpgradedSpAttack = 0;
  double wildUpgradedSpDefence = 0;
  double wildUpgradedSpeed = 0;

  Future<void> getUserTeamPokemons() async {
    var box = await Hive.openBox("PokemonUserTeam");
    List<dynamic> pokeListFromHiveDynamic = box.get("UserTeam", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();

    userTeam = List.filled(6, null);
    for (int i = 0; i < pokeListFromHive.length && i < userTeam.length; i++) {
      userTeam[i] = pokeListFromHive[i];
    }
    PokemonUser pkUser = userTeam.first!;
    await setUserPokemonData(pkUser);
    await getNewUserPokemon(pkUser);
  }

  Future<void> getNewUserPokemon(PokemonUser pkUser) async{
    Pokemon pkUserPokemon = pkUser.pokemon;
    Pokemon buffedUserPokemon = Pokemon(
        pokeDexIndex: pkUserPokemon.pokeDexIndex,
        name: pkUserPokemon.name,
        rarity: pkUserPokemon.rarity,
        type: pkUserPokemon.type,
        pokeStats: PokeStats(
            hp: userUpgradedHp,
            attack: userUpgradedAttack,
            defence: userUpgradedDefence,
            specialAttack: userUpgradedSpAttack,
            specialDefence: userUpgradedSpDefence,
            speed: userUpgradedSpeed),
        region: pkUserPokemon.region,
        weakness: pkUserPokemon.weakness,
        gifFront: pkUserPokemon.gifFront,
        gifBack: pkUserPokemon.gifBack);
    PokemonUser buffedUserPokemonBattle = PokemonUser(pokemon: buffedUserPokemon, lvl: pkUser.lvl, hashId: pkUser.hashId, pokemonExp: pkUser.pokemonExp);
    //we need to get exp which it's need to get =>
    setState(() {
      currentUserPokemon = buffedUserPokemonBattle;
      currentHpPokemonUser = buffedUserPokemonBattle.pokemon.pokeStats.hp;
      userSelectedPokemonMaxHp = buffedUserPokemonBattle.pokemon.pokeStats.hp;
      expNeedToNextLvl = (pkUser.lvl>=300)? 0 : experienceDataList[pkUser.lvl-1];
      currentExpPokemonUser = pkUser.pokemonExp;
    });
  }

  Future<void> setDataFromHivePokedexInitialized() async{
    var box = await Hive.openBox("PokemonUserPokedex");

    // Read the list from Hive and cast it to List<PokedexPokemonModel>
    List<dynamic> pokeListFromHiveDynamic = box.get("Pokedex", defaultValue: []);

    // Cast the list to List<PokedexPokemonModel>
    List<PokedexPokemonModel> pokeListFromHive = pokeListFromHiveDynamic.cast<PokedexPokemonModel>();
    setState(() {
      hivePokedexList = pokeListFromHive;
    });
  }

  Future<void> setUserPokemonData(PokemonUser pokemonUser) async{
    final pokemon_pokmonUser = pokemonUser.pokemon;
    // we need to get data from pokedex =>
    late Pokemon pokemonFromPokedex;
    for(int i=0; i<hivePokedexList.length; i++){
      if(hivePokedexList[i].pokemon.name == pokemon_pokmonUser.name){
        pokemonFromPokedex = hivePokedexList[i].pokemon;
        break;
      }
    }

    userBasicHp = pokemonFromPokedex.pokeStats.hp;
    userBasicAttack = pokemonFromPokedex.pokeStats.attack;
    userBasicDefence = pokemonFromPokedex.pokeStats.defence;
    userBasicSpAttack = pokemonFromPokedex.pokeStats.specialAttack;
    userBasicSpDefence = pokemonFromPokedex.pokeStats.specialDefence;
    userBasicSpeed = pokemonFromPokedex.pokeStats.speed;

    //Set buffed data =>
    if(pokemon_pokmonUser.rarity == Rarity.casual){
      userUpgradedHp = pokemonFromPokedex.pokeStats.hp + 2*(pokemonUser.lvl-1);
      userUpgradedAttack = pokemonFromPokedex.pokeStats.attack + (pokemonUser.lvl-1);
      userUpgradedDefence = pokemonFromPokedex.pokeStats.defence + (pokemonUser.lvl-1);
      userUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + (pokemonUser.lvl-1);
      userUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + (pokemonUser.lvl-1);
      userUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + (pokemonUser.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.rare){
      userUpgradedHp = pokemonFromPokedex.pokeStats.hp + 3*(pokemonUser.lvl-1);
      userUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 2*(pokemonUser.lvl-1);
      userUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 2*(pokemonUser.lvl-1);
      userUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 2*(pokemonUser.lvl-1);
      userUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 2*(pokemonUser.lvl-1);
      userUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 2*(pokemonUser.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.epic){
      userUpgradedHp = pokemonFromPokedex.pokeStats.hp + 4*(pokemonUser.lvl-1);
      userUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 3*(pokemonUser.lvl-1);
      userUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 3*(pokemonUser.lvl-1);
      userUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 3*(pokemonUser.lvl-1);
      userUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 3*(pokemonUser.lvl-1);
      userUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 3*(pokemonUser.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.mystic){
      userUpgradedHp = pokemonFromPokedex.pokeStats.hp + 5*(pokemonUser.lvl-1);
      userUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 4*(pokemonUser.lvl-1);
      userUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 4*(pokemonUser.lvl-1);
      userUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 4*(pokemonUser.lvl-1);
      userUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 4*(pokemonUser.lvl-1);
      userUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 4*(pokemonUser.lvl-1);
    }
    else{
      userUpgradedHp = pokemonFromPokedex.pokeStats.hp + 7*(pokemonUser.lvl-1);
      userUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 5*(pokemonUser.lvl-1);
      userUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 5*(pokemonUser.lvl-1);
      userUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 5*(pokemonUser.lvl-1);
      userUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 5*(pokemonUser.lvl-1);
      userUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 5*(pokemonUser.lvl-1);
    }
  }

  Future<void> setWildPokemonData(PokemonWild pokemonWild) async{
    final pokemon_pokmonUser = pokemonWild.pokemon;

    late Pokemon pokemonFromPokedex;
    for(int i=0; i<hivePokedexList.length; i++){
      if(hivePokedexList[i].pokemon.name == pokemon_pokmonUser.name){
        pokemonFromPokedex = hivePokedexList[i].pokemon;
        break;
      }
    }

    wildBasicHp = pokemonFromPokedex.pokeStats.hp;
    wildBasicAttack = pokemonFromPokedex.pokeStats.attack;
    wildBasicDefence = pokemonFromPokedex.pokeStats.defence;
    wildBasicSpAttack = pokemonFromPokedex.pokeStats.specialAttack;
    wildBasicSpDefence = pokemonFromPokedex.pokeStats.specialDefence;
    wildBasicSpeed = pokemonFromPokedex.pokeStats.speed;

    if(pokemon_pokmonUser.rarity == Rarity.casual){
      wildUpgradedHp = pokemonFromPokedex.pokeStats.hp + 2*(pokemonWild.lvl-1);
      wildUpgradedAttack = pokemonFromPokedex.pokeStats.attack + (pokemonWild.lvl-1);
      wildUpgradedDefence = pokemonFromPokedex.pokeStats.defence + (pokemonWild.lvl-1);
      wildUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + (pokemonWild.lvl-1);
      wildUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + (pokemonWild.lvl-1);
      wildUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + (pokemonWild.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.rare){
      wildUpgradedHp = pokemonFromPokedex.pokeStats.hp + 3*(pokemonWild.lvl-1);
      wildUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 2*(pokemonWild.lvl-1);
      wildUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 2*(pokemonWild.lvl-1);
      wildUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 2*(pokemonWild.lvl-1);
      wildUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 2*(pokemonWild.lvl-1);
      wildUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 2*(pokemonWild.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.epic){
      wildUpgradedHp = pokemonFromPokedex.pokeStats.hp + 4*(pokemonWild.lvl-1);
      wildUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 3*(pokemonWild.lvl-1);
      wildUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 3*(pokemonWild.lvl-1);
      wildUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 3*(pokemonWild.lvl-1);
      wildUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 3*(pokemonWild.lvl-1);
      wildUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 3*(pokemonWild.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.mystic){
      wildUpgradedHp = pokemonFromPokedex.pokeStats.hp + 5*(pokemonWild.lvl-1);
      wildUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 4*(pokemonWild.lvl-1);
      wildUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 4*(pokemonWild.lvl-1);
      wildUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 4*(pokemonWild.lvl-1);
      wildUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 4*(pokemonWild.lvl-1);
      wildUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 4*(pokemonWild.lvl-1);
    }
    else{
      wildUpgradedHp = pokemonFromPokedex.pokeStats.hp + 7*(pokemonWild.lvl-1);
      wildUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 5*(pokemonWild.lvl-1);
      wildUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 5*(pokemonWild.lvl-1);
      wildUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 5*(pokemonWild.lvl-1);
      wildUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 5*(pokemonWild.lvl-1);
      wildUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 5*(pokemonWild.lvl-1);
    }
  }

  Future<void> getNewWildPokemon() async{
    randomVal = _random.nextInt(widget.pokeWildList.length);
    PokemonWild wildDataPokemon = widget.pokeWildList[randomVal];
    await setWildPokemonData(wildDataPokemon);
    Pokemon pokemonData = wildDataPokemon.pokemon;
    Pokemon buffedPokemon = Pokemon(
        pokeDexIndex: pokemonData.pokeDexIndex,
        name: pokemonData.name,
        rarity: pokemonData.rarity,
        type: pokemonData.type,
        pokeStats: PokeStats(
            hp: wildUpgradedHp,
            attack: wildUpgradedAttack,
            defence: wildUpgradedDefence,
            specialAttack: wildUpgradedSpAttack,
            specialDefence: wildUpgradedSpDefence,
            speed: wildUpgradedSpeed),
        region: pokemonData.region,
        weakness: pokemonData.weakness,
        gifFront: pokemonData.gifFront,
        gifBack: pokemonData.gifBack);
    PokemonWild buffedPokemonWld = PokemonWild(pokemon: buffedPokemon, lvl: wildDataPokemon.lvl);
    setState(() {
      currentWildPokemon = buffedPokemonWld;
      wildSelectedPokemonMaxHp = buffedPokemonWld.pokemon.pokeStats.hp;
      currentHpPokemonWild = buffedPokemonWld.pokemon.pokeStats.hp;
    });
  }

  Future<void> getAnotherUserPokemon() async{
    //we should add current user pokemonto defeated list =>
    defeatedUserPokemons.add(currentUserPokemon.hashId);
    bool userHaveAnotherPokemon = false;
    //We need to work with all users team :
    for(int i=0; i<userTeam.length; i++){
      final potentialPokemon = userTeam[i];
      if (potentialPokemon != null && !defeatedUserPokemons.contains(potentialPokemon.hashId)) {
        // If we find a valid Pokémon not in the defeated list, use it
        await setUserPokemonData(potentialPokemon);
        await getNewUserPokemon(potentialPokemon);
        setState(() {
          userHaveAnotherPokemon = true;
        });
        break;
      }
    }
    //Now check logic if user had any pokemon :
    if(userHaveAnotherPokemon == false){
      //show alert with one option to leave location in future, current just toast =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.defeat_string,
                style: const TextStyle(
                fontSize: 18, color: CupertinoColors.black, fontWeight: FontWeight.w600 , letterSpacing: 0.01
            )),
            content: Text(AppLocalizations.of(context)!.no_more_pokemons_string,
                style: const TextStyle(
                fontSize: 18, color: CupertinoColors.black, fontWeight: FontWeight.w600 , letterSpacing: 0.01
            )),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async{
                        Navigator.pop(context); // Close the dialog
                        Navigator.pop(context); // Exit the battle
                      },
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(searchBoxColor)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                            AppLocalizations.of(context)!.close_string,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                            )),
                      )
                  ),
                ),
              )
            ],
          );
        },
      );
    }
  }

  Future<void> getUserCoins() async{
    var box = await Hive.openBox("PokemonUserDataBase");
    int userCoins = box.get("UserMoneys", defaultValue: 0);
    setState(() {
      showUserMoney = userCoins;
    });
  }

  Future<void> getUserPokeballs() async{
    var box = await Hive.openBox("PokemonUserInventory");
    List<dynamic> pokeListFromHiveDynamic = box.get("PokeballsUserInventory", defaultValue: []);
    List<int> pokeListFromHive = pokeListFromHiveDynamic.cast<int>();
    setState(() {
      userPokeBalls = pokeListFromHive;
    });
  }

  Widget showPokeball(String pokeballName, String pokeballImagePath,
      PokeballsTypeCatch pokeballsTypeCatch, int pokeballsAmmount){
    return GestureDetector(
      onTap: (){
        //Firstly we need to check if they are same :
        if(selectedPokeball != pokeballsTypeCatch){
          setState(() {
            //Here we need to change our type of selected ball
            selectedPokeball = pokeballsTypeCatch;
          });
        }
      },
      child: Container(
        width: 75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (selectedPokeball == pokeballsTypeCatch)? searchBoxColor : searchBoxColor.withOpacity(0.2)
        ),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  pokeballImagePath,
                  height: 36,
                  width: 36,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 5,),
                Text(
                  "$pokeballsAmmount", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: (selectedPokeball == pokeballsTypeCatch)?Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.w700, decoration: TextDecoration.none),
                ),
              ],
            ),
        ),
      ),
    );
  }

  // Method to trigger animation
  Future<void> triggerFightAnimationUser() async{
    await controllerAnimationUser.forward().then((_) => controllerAnimationUser.reverse());
  }

  Future<void> triggerFightAnimationWild() async{
    await controllerAnimationWild.forward().then((_) => controllerAnimationWild.reverse());
  }

  String getNameAttack(PokeAction pokeAction){
    if(pokeAction == PokeAction.Attack){
     return  AppLocalizations.of(context)!.pokemon_stats_attack;
    }
    else if(pokeAction == PokeAction.Defence){
      return  AppLocalizations.of(context)!.pokemon_stats_defence;
    }
    else if(pokeAction == PokeAction.ElemtalAttack){
      return  AppLocalizations.of(context)!.pokemon_stats_special_attack;
    }
    else{
      return  AppLocalizations.of(context)!.pokemon_stats_special_defence;
    }
  }

  PokeAction randomWildPokemonAction(){
    final randomPokemonAction = _randomPokeActions.nextInt(3);
    if(randomPokemonAction == 0){
      //Attack
      return PokeAction.Attack;
    }
    else if(randomPokemonAction == 1){
      //Elemtal attack
      return PokeAction.ElemtalAttack;
    }
    else if(randomPokemonAction == 2){
      //Defence
      return PokeAction.Defence;
    }
    else{
      //Elemtal defence
      return PokeAction.ElemtalDefence;
    }
  }

  Future<void> registerPokemon(PokemonWild pokemon) async{
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
        pokemon: Pokemon(
            pokeDexIndex: pokemon.pokemon.pokeDexIndex,
            name: pokemon.pokemon.name,
            rarity: pokemon.pokemon.rarity,
            type: pokemon.pokemon.type,
            pokeStats: PokeStats(
                hp: wildBasicHp,
                attack: wildBasicAttack,
                defence: wildBasicDefence,
                specialAttack: wildBasicSpAttack,
                specialDefence: wildBasicSpDefence,
                speed: wildBasicSpeed),
            region: pokemon.pokemon.region,
            weakness: pokemon.pokemon.weakness,
            gifFront: pokemon.pokemon.gifFront,
            gifBack: pokemon.pokemon.gifBack),
        lvl: pokemon.lvl,
        hashId: "${year}_${month}_${day}_${minute}_${second}_${pokemon.pokemon.name}",
        pokemonExp: 0
    );
    pokeListFromHive.add(firstPokemon);
    await box.put("PokeUserInventory", pokeListFromHive);

    //set this pokemon found in pokedex =>
    for(int i=0; i<pokeListFromHive1.length; i++){
      if(pokeListFromHive1[i].pokemon == pokemon){
        pokeListFromHive1[i] = PokedexPokemonModel(pokemon: pokemon.pokemon, isFound: true);
        break;
      }
    }
    await box1.put("Pokedex", pokeListFromHive1);
  }

  Future<void> usedPokeball(PokeballsTypeCatch pokeball) async{
    var box1 = await Hive.openBox("PokemonUserInventory");
    List<dynamic> pokeListFromHiveDynamic = box1.get("PokeballsUserInventory", defaultValue: []);
    List<int> pokeListFromHive = pokeListFromHiveDynamic.cast<int>();
    if(pokeball == PokeballsTypeCatch.Pokeball){
      //Add Pokeball
      int pokeBallsCount = pokeListFromHive[0];
      pokeListFromHive[0] = pokeBallsCount - 1;
    }
    else if(pokeball == PokeballsTypeCatch.Greatball){
      //Add Great Ball
      int greatBallsCount = pokeListFromHive[1];
      pokeListFromHive[1] = greatBallsCount - 1;
    }
    else if(pokeball == PokeballsTypeCatch.Ultraball){
      //Add Ultra Ball
      int ultraBallsCount = pokeListFromHive[2];
      pokeListFromHive[2] = ultraBallsCount - 1;
    }
    else{
      //Add master ball
      int masterBallsCount = pokeListFromHive[3];
      pokeListFromHive[3] = masterBallsCount - 1;
    }
    await box1.put("PokeballsUserInventory", pokeListFromHive);
    setState(() {
      userPokeBalls = pokeListFromHive;
    });
  }

  Future<void> catchPokemonPokeball(PokeballsTypeCatch pokeball) async{
    await usedPokeball(pokeball);
    // we need to calc current wild pokemon / current wild pokemon max hp
    double diff = wildSelectedPokemonMaxHp / (currentHpPokemonWild * 20);

    double catchRate = diff;
    if(pokeball == PokeballsTypeCatch.Pokeball){
      catchRate = catchRate;
    }
    else if(pokeball == PokeballsTypeCatch.Greatball){
      catchRate = catchRate * 5;
    }
    else if(pokeball == PokeballsTypeCatch.Ultraball){
      catchRate = catchRate * 10;
    }
    else{
      catchRate = 1;
    }
    // if catch rate is equal or higher then 1 we captire pokemon =>
    if(catchRate >=1){
      //We capture pokemon and should get another
      //set records
      Fluttertoast.showToast(
        msg: "${AppLocalizations.of(context)!.pokemon_cathed} ${currentWildPokemon.pokemon.name}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      setState(() {
        textLastMove = "${AppLocalizations.of(context)!.pokemon_cathed} ${currentWildPokemon.pokemon.name}";
      });
      allLogText = "$allLogText\n$textLastMove";
      //Register to user new pokemon :
      await registerPokemon(currentWildPokemon);
      //get new wild pokemon
      await getNewWildPokemon();
    }
    else{
      //we should use random
      int randomGenVal =  _randomCatchProbability.nextInt(100);
      if(randomGenVal/100 > catchRate){
        // Pokemon not captured - it should attack;
        // register in logs =>
        setState(() {
          textLastMove = "${AppLocalizations.of(context)!.pokemon_uncatched} ${currentWildPokemon.pokemon.name}";
        });
        allLogText = "$allLogText\n$textLastMove";
        await fightBattle(PokeAction.Capture);
      }
      else{
        //We capture pokemon and should get another
        //set records
        Fluttertoast.showToast(
          msg: "${AppLocalizations.of(context)!.pokemon_cathed} ${currentWildPokemon.pokemon.name}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        setState(() {
          textLastMove = "${AppLocalizations.of(context)!.pokemon_cathed} ${currentWildPokemon.pokemon.name}";
        });
        allLogText = "$allLogText\n$textLastMove";
        //Register to user new pokemon :
        await registerPokemon(currentWildPokemon);
        //get new wild pokemon
        await getNewWildPokemon();
      }
    }
  }

  Future<void> showBattleLogs(double width) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: scaffoldColor,
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          title: Text(
              AppLocalizations.of(context)!.logs_string, textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, color: darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
              )
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          content: SizedBox(
            width: width,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                      allLogText,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 18, color: CupertinoColors.black, fontWeight: FontWeight.w400 , letterSpacing: 0.01
                      )),
              ),
            ),
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async{
                        Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all<Color>(searchBoxColor)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                          AppLocalizations.of(context)!.close_string,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                          )),
                    )
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void addRecordDescripton(PokeAction pokeAction, String pokemonName){
    if(pokeAction == PokeAction.Capture){
      textLastMove = "${AppLocalizations.of(context)!.pokeball_throwed} ${currentWildPokemon.pokemon.name}";
    }
    else{
      setState(() {
        textLastMove = "$pokemonName ${AppLocalizations.of(context)!.used_string} ${getNameAttack(pokeAction)}";
      });
    }
    if(allLogText.isEmpty){ allLogText = textLastMove;}
    else{allLogText = "$allLogText\n$textLastMove";}
  }

  Future<void> userPokemonFight(PokeAction pokeAction) async{
    //User firstly beat by his own move.
    if(pokeAction == PokeAction.Defence || pokeAction == PokeAction.ElemtalDefence || pokeAction == PokeAction.Capture){
      //We shouldn't animateaction
      addRecordDescripton(pokeAction, currentUserPokemon.pokemon.name);
      if(pokeAction == PokeAction.Defence){
        setState(() {
          addedShieldCasualUserPokemon = userUpgradedDefence / 2;
        });
      }
      else if(pokeAction == PokeAction.ElemtalDefence){
        setState(() {
          addedShieldElementalUserPokemon = userUpgradedSpDefence / 2;
        });
      }
      else{

      }
    }
    else{
      addRecordDescripton(pokeAction, currentUserPokemon.pokemon.name);
      setState(() {
        animatingImageUser = true;
      });
      await triggerFightAnimationUser();
      //We should update opponent pokemon health.
      if(pokeAction == PokeAction.Attack){
        //If attack we minus constant value=>
        final minusHp = (wildUpgradedDefence/2 - userUpgradedAttack);
        if(minusHp >= 0){
          // that means wild pokemon shield is higher then our attack
          final result = currentHpPokemonWild - 5;
          setState(() {
            currentHpPokemonWild = result;
          });
        }
        else{
          //If our attack is higher then wild pokemon defence then we should minus our rest of attack with shield power
          final shieldMinusHp = addedShieldCasualWildPokemon + minusHp;
          if(shieldMinusHp >=0){
            //If overall shield protect then do nothing
            final result = currentHpPokemonWild - 10;
            setState(() {
              currentHpPokemonWild = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            final result = currentHpPokemonWild + shieldMinusHp;
            if(result <=0){
              setState(() {
                currentHpPokemonWild = 0;
              });
            }
            else{
              setState(() {
                currentHpPokemonWild = result;
              });
            }
          }
        }
      }
      else{
        // If elemental attack we should check if pokemon hve weakness against this type=>
        final minusHp = wildUpgradedSpDefence *0.75 - userUpgradedSpAttack;

        if(minusHp >= 0){
          // that means wild pokemon shield is higher then our attack
          final result = currentHpPokemonWild - 5;
          setState(() {
            currentHpPokemonWild = result;
          });
        }
        else{
          //If our attack is higher then wild pokemon defence then we should minus our rest of attack with shield power
          final shieldMinusHp = addedShieldElementalWildPokemon + minusHp;
          if(shieldMinusHp >=0){
            //If overall shield protect then do nothing
            final result = currentHpPokemonWild - 10;
            setState(() {
              currentHpPokemonWild = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            if(currentWildPokemon.pokemon.weakness.contains(currentUserPokemon.pokemon.type.first)){
              final result = currentHpPokemonWild + shieldMinusHp * 2;
              if(result <=0){
                setState(() {
                  currentHpPokemonWild = 0;
                });
              }
              else{
                setState(() {
                  currentHpPokemonWild = result;
                });
              }
            }
            else{
              //pokemon don't have weakness against this type :
              final result = currentHpPokemonWild + shieldMinusHp;
              if(result <=0){
                setState(() {
                  currentHpPokemonWild = 0;
                });
              }
              else{
                setState(() {
                  currentHpPokemonWild = result;
                });
              }
            }
          }
        }

      }
    }
  }

  Future<void> wildPokemonFight() async{
    PokeAction wildPokemonAction = randomWildPokemonAction();
    if(wildPokemonAction == PokeAction.Defence || wildPokemonAction == PokeAction.ElemtalDefence){
      //We shouldn't animateaction
      addRecordDescripton(wildPokemonAction, currentWildPokemon.pokemon.name);
      if(wildPokemonAction == PokeAction.Defence){
        setState(() {
          addedShieldCasualWildPokemon = wildUpgradedDefence / 2;
        });
      }
      else{
        setState(() {
          addedShieldElementalWildPokemon = wildUpgradedSpDefence / 2;
        });
      }
    }
    else{
      setState(() {
        animatingWildPokemon = true;
      });
      await triggerFightAnimationWild();
      addRecordDescripton(wildPokemonAction, currentWildPokemon.pokemon.name);
      setState(() {
        animatingWildPokemon = false;
      });
      //Update users pokemon health.
      if(wildPokemonAction == PokeAction.Attack){
        //If attack we minus constant value=>
        final minusHp = userUpgradedDefence/2 - wildUpgradedAttack;

        if(minusHp >= 0){
          // that means our pokemon shield is higher then wild pokemon attack
          final result = currentHpPokemonUser - 5;
          setState(() {
            currentHpPokemonUser = result;
          });
        }
        else{
          final shieldMinusHp = addedShieldCasualUserPokemon + minusHp;
          if(shieldMinusHp >=0){
            //If overall shield protect then do nothing
            final result = currentHpPokemonUser - 10;
            setState(() {
              currentHpPokemonUser = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            final result = currentHpPokemonUser + shieldMinusHp;
            if(result <=0){
              setState(() {
                currentHpPokemonUser = 0;
              });
            }
            else{
              setState(() {
                currentHpPokemonUser = result;
              });
            }
          }
        }

      }
      else{
        // If elemental attack we should check if pokemon hve weakness against this type=>
        final minusHp = wildUpgradedSpDefence *0.75 - userUpgradedSpAttack;


        if(minusHp >= 0){
          // that means wild pokemon shield is higher then our attack
          final result = currentHpPokemonUser - 5;
          setState(() {
            currentHpPokemonUser = result;
          });
        }
        else{
          //If our attack is higher then wild pokemon defence then we should minus our rest of attack with shield power
          final shieldMinusHp = addedShieldElementalUserPokemon + minusHp;
          if(shieldMinusHp >=0){
            //If overall shield protect then do nothing
            final result = currentHpPokemonUser - 10;
            setState(() {
              currentHpPokemonUser = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            if(currentUserPokemon.pokemon.weakness.contains(currentWildPokemon.pokemon.type.first)){
              final result = currentHpPokemonUser + shieldMinusHp * 2;
              if(result <=0){
                setState(() {
                  currentHpPokemonUser = 0;
                });
              }
              else{
                setState(() {
                  currentHpPokemonUser = result;
                });
              }
            }
            else{
              //pokemon don't have weakness against this type :
              final result = currentHpPokemonUser + shieldMinusHp;
              if(result <=0){
                setState(() {
                  currentHpPokemonUser = 0;
                });
              }
              else{
                setState(() {
                  currentHpPokemonUser = result;
                });
              }
            }
          }
        }

      }
    }
  }

  Future<void> addMoneysUser(int ammountMoneys) async{
    var box = await Hive.openBox("PokemonUserDataBase");
    int userCoins = showUserMoney + ammountMoneys;
    await box.put("UserMoneys", userCoins);
    setState(() {
      showUserMoney = userCoins;
    });
  }

  Future<void> addUserPokemonExperience(int ammountExp) async{
    if(currentUserPokemon.lvl>=300){
      //We can't add more exp to pokemon
    }
    else{
      //Firstly we should add experience to user pokemon =>
      int totalExp = currentUserPokemon.pokemonExp + ammountExp;
      //now we should check if total exp is enought to get new lvl =>
      if(totalExp > expNeedToNextLvl){
        //calc difference and update user pokemon
        int diff = totalExp - expNeedToNextLvl;
        late PokemonUser raisedPokemon;
        if(currentUserPokemon.lvl == 299){
          raisedPokemon = PokemonUser(pokemon: currentUserPokemon.pokemon,
              lvl: currentUserPokemon.lvl +1, hashId: currentUserPokemon.hashId, pokemonExp: 0);
        }
        else{
          raisedPokemon = PokemonUser(pokemon: currentUserPokemon.pokemon,
              lvl: currentUserPokemon.lvl +1, hashId: currentUserPokemon.hashId, pokemonExp: diff);
        }
        await setUserPokemonData(raisedPokemon);
        PokeStats updatedPokeStats = PokeStats(
            hp: userUpgradedHp,
            attack: userUpgradedAttack,
            defence: userUpgradedDefence,
            specialAttack: userUpgradedSpAttack,
            specialDefence: userUpgradedSpDefence,
            speed: userUpgradedSpeed);
        await updateUserPokemonData(raisedPokemon);
        setState(() {
          currentUserPokemon = raisedPokemon;
          currentExpPokemonUser = diff;
          expNeedToNextLvl = experienceDataList[currentUserPokemon.lvl -1];
          currentHpPokemonUser = updatedPokeStats.hp;
          userSelectedPokemonMaxHp = updatedPokeStats.hp;
        });
      }
      else if(totalExp == expNeedToNextLvl){
        //we must update user pokemon data =>
        PokemonUser raisedPokemon = PokemonUser(pokemon: currentUserPokemon.pokemon,
            lvl: currentUserPokemon.lvl +1, hashId: currentUserPokemon.hashId, pokemonExp: 0);
        await setUserPokemonData(raisedPokemon);
        PokeStats updatedPokeStats = PokeStats(
            hp: userUpgradedHp,
            attack: userUpgradedAttack,
            defence: userUpgradedDefence,
            specialAttack: userUpgradedSpAttack,
            specialDefence: userUpgradedSpDefence,
            speed: userUpgradedSpeed);
        await updateUserPokemonData(raisedPokemon);
        setState(() {
          currentUserPokemon = raisedPokemon;
          currentExpPokemonUser = 0;
          expNeedToNextLvl = experienceDataList[currentUserPokemon.lvl -1];
          currentHpPokemonUser = updatedPokeStats.hp;
          userSelectedPokemonMaxHp = updatedPokeStats.hp;
        });
      }
      else{
        //update user pokemon exp
        PokemonUser raisedPokemon = PokemonUser(pokemon: currentUserPokemon.pokemon,
            lvl: currentUserPokemon.lvl, hashId: currentUserPokemon.hashId, pokemonExp: totalExp);
        await updateUserPokemonData(raisedPokemon);
        setState(() {
          currentUserPokemon = raisedPokemon;
          currentExpPokemonUser = totalExp;
        });
      }
    }
  }

  Future<void> updateUserPokemonData(PokemonUser pokemonUser) async {
    var box = await Hive.openBox("PokemonUserInventory");

    // Retrieve the current Pokémon inventory
    List<dynamic> pokeListFromHiveDynamic = box.get(
        "PokeUserInventory", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<
        PokemonUser>();

    // Find the Pokémon in the inventory by hashId
    int pokemonIndex = pokeListFromHive.indexWhere((
        inventoryPokemon) => inventoryPokemon.hashId == pokemonUser.hashId);
    if (pokemonIndex != -1) {
      // Replace the Pokémon with its evolved form
      pokeListFromHive[pokemonIndex] = PokemonUser(
          pokemon: Pokemon(
              pokeDexIndex: pokemonUser.pokemon.pokeDexIndex,
              name: pokemonUser.pokemon.name,
              rarity: pokemonUser.pokemon.rarity,
              type: pokemonUser.pokemon.type,
              pokeStats: PokeStats(
                  hp: userBasicHp,
                  attack: userBasicAttack,
                  defence: userBasicDefence,
                  specialAttack: userBasicSpAttack,
                  specialDefence: userBasicSpDefence,
                  speed: userBasicSpeed),
              region: pokemonUser.pokemon.region,
              weakness: pokemonUser.pokemon.weakness,
              gifFront: pokemonUser.pokemon.gifFront,
              gifBack: pokemonUser.pokemon.gifBack),
          lvl: pokemonUser.lvl,
          hashId: pokemonUser.hashId,
          pokemonExp: pokemonUser.pokemonExp
      );
      // Update the inventory in the box
      await box.put("PokeUserInventory", pokeListFromHive);
      await updateTeamPokemon(pokemonUser);
    }
  }

  Future<void> updateTeamPokemon(PokemonUser pokemonUser) async {
    var teamBox = await Hive.openBox("PokemonUserTeam");

    // Retrieve the current team
    List<dynamic> teamListFromHiveDynamic = teamBox.get("UserTeam", defaultValue: []);
    List<PokemonUser> teamListFromHive = teamListFromHiveDynamic.cast<PokemonUser>();

    // Find and update the Pokémon in the team by hashId
    int teamPokemonIndex = teamListFromHive.indexWhere((teamPokemon) => teamPokemon.hashId == pokemonUser.hashId);
    if (teamPokemonIndex != -1) {
      // Replace the Pokémon with its evolved form
      teamListFromHive[teamPokemonIndex] = PokemonUser(
          pokemon: pokemonUser.pokemon,
          lvl: pokemonUser.lvl,
          hashId: pokemonUser.hashId,
          pokemonExp: pokemonUser.pokemonExp
      );

      // Update the team in the box
      await teamBox.put("UserTeam", teamListFromHive);
    }
  }

  Future<void> fightBattle(PokeAction pokeAction) async{
    //So we are work like :
     if(animatingImageUser == true || animatingWildPokemon == true){
       //TODO : DO NOTHING IF THEY ARE STILL FIGHT
     }
     else{
       //User pokemon fight
       await userPokemonFight(pokeAction);
       //Then we should check if wild pokemon hp is lower or equal to 0 :
       if(currentHpPokemonWild <=0){
         //We should give to user gold and exp to pokemon:
         if(currentWildPokemon.lvl >= 70){
           addMoneysUser(100);
           addUserPokemonExperience(25);
         }
         else if(currentWildPokemon.lvl >= 50){
           addMoneysUser(50);
           addUserPokemonExperience(15);
         }
         else if(currentWildPokemon.lvl >= 30){
           addMoneysUser(30);
           addUserPokemonExperience(7);
         }
         else if(currentWildPokemon.lvl >= 11){
           addMoneysUser(20);
           addUserPokemonExperience(5);
         }
         else{
           addMoneysUser(10);
           addUserPokemonExperience(3);
         }
         //Then pokemon should fainted :
         await getNewWildPokemon();
         setState(() {
           animatingImageUser = false;
         });
       }
       else{
         //We should clear text description
         await Future.delayed(Duration(seconds: 1));
         setState(() {
           animatingImageUser = false;
           textLastMove = "";
         });
         //Then randomly we should choose what uses another pokemon.
         await wildPokemonFight();
         //Then we should trigger logic equathion if users pokemon hp lower or equal to 0 then we should get next pokemon in row.
         if(currentHpPokemonUser<=0){
           await getAnotherUserPokemon();
         }
       }
     }
  }

  Future<void> setupAnimations() async{
    // Initialize the animation controller
    controllerAnimationUser = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation duration
    );

    // Define the offset animation for small movement
    animationImageUser = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(20, -20), // Small up-right movement
    ).animate(CurvedAnimation(parent: controllerAnimationUser, curve: Curves.easeInOut));

    controllerAnimationWild = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation duration
    );

    // Define the offset animation for small movement
    animationWildPokemon = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-20, 20), // Small up-right movement
    ).animate(CurvedAnimation(parent: controllerAnimationWild, curve: Curves.easeInOut));
  }

  Future<void> initVoid() async{
    //get pokedex data =>
    await setDataFromHivePokedexInitialized();
    //Get users pokemons team
    await getUserTeamPokemons();
    //Get users pokeballs :
    await getUserPokeballs();
    //get wild pokemon
    await getNewWildPokemon();
    //setup animations :
    await setupAnimations();
    //get user gold:
    await getUserCoins();
    setState(() {
      selectedPokeball = PokeballsTypeCatch.Pokeball;
      dataGet = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initVoid();
  }

  @override
  void dispose() {
    controllerAnimationUser.dispose();
    controllerAnimationWild.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: dataGet? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              SizedBox(
                width: width,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "$showUserMoney",
                          style: TextStyle(fontSize: 26, color: Colors.grey[600], fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 5,),
                        FaIcon(FontAwesomeIcons.coins , color: goldColor, size: 22,)
                      ],
                    ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: animationImageUser,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: animationImageUser.value,
                                child: child,
                              );
                            },
                            child: Image.asset(
                              currentUserPokemon.pokemon.gifBack,
                              key: gifKeyImageUser,
                              height: 170,
                              width: 170,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain,
                            )
                          ),
                          const SizedBox(height: 5,),
                          Text(
                              showPokemonNameCyrillic(currentUserPokemon.pokemon.name),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )
                          ),
                          const SizedBox(height: 3,),
                          Text(
                              "Lvl. ${currentUserPokemon.lvl}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )
                          ),
                          const SizedBox(height: 5,),
                          LinearPercentIndicator(
                            width: 140.0,
                            lineHeight: 14.0,
                            percent: currentHpPokemonUser/userSelectedPokemonMaxHp,
                            center: Text(
                              "$currentHpPokemonUser/$userSelectedPokemonMaxHp",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              ),
                            ),
                            barRadius: Radius.circular(15),
                            backgroundColor: Colors.grey.shade200,
                            progressColor: Colors.red.shade500,
                          ),
                          const SizedBox(height: 10,),
                          (currentUserPokemon.lvl >=300)?
                          LinearPercentIndicator(
                            width: 140.0,
                            lineHeight: 14.0,
                            percent: 1.0,
                            center: Text(
                              showPokemonNameCyrillic("Maximum"),
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              ),
                            ),
                            barRadius: Radius.circular(15),
                            backgroundColor: Colors.grey.shade400,
                            progressColor: Colors.green.shade500,
                          ) :
                          LinearPercentIndicator(
                            width: 140.0,
                            lineHeight: 14.0,
                            percent: currentExpPokemonUser/expNeedToNextLvl,
                            center: Text(
                              "$currentExpPokemonUser/$expNeedToNextLvl",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              ),
                            ),
                            barRadius: Radius.circular(15),
                            backgroundColor: Colors.grey.shade400,
                            progressColor: Colors.green.shade500,
                          ),
                        ],
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                              animation: animationWildPokemon,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: animationWildPokemon.value,
                                  child: child,
                                );
                              },
                              child: Image.asset(
                                currentWildPokemon.pokemon.gifFront,
                                key: gifKeyImageWild,
                                height: 120,
                                width: 120,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.contain,
                              )
                          ),
                          const SizedBox(height: 5,),
                          Text(
                              showPokemonNameCyrillic(currentWildPokemon.pokemon.name),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )
                          ),
                          const SizedBox(height: 3,),
                          Text(
                              "Lvl. ${currentWildPokemon.lvl}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )
                          ),
                          const SizedBox(height: 5,),
                          LinearPercentIndicator(
                            width: 140.0,
                            lineHeight: 14.0,
                            percent: currentHpPokemonWild/wildSelectedPokemonMaxHp,
                            center: Text(
                              "$currentHpPokemonWild/$wildSelectedPokemonMaxHp",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              ),
                            ),
                            barRadius: Radius.circular(15),
                            backgroundColor: Colors.grey.shade200,
                            progressColor: Colors.red.shade500,
                          ),
                        ],
                      ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                width: width,
                decoration: BoxDecoration(
                  color: searchBoxColor,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                                textLastMove,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16, color: scaffoldColor, fontWeight: FontWeight.bold , letterSpacing: 0.01
                                )
                            ),
                        ),
                        GestureDetector(
                          onTap: (){
                             showBattleLogs(width);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: scaffoldColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: FaIcon(FontAwesomeIcons.solidFileLines, color: searchBoxColor, size: 36,),
                            ),
                          ),
                        )
                      ],
                    ),
                ),
              ),
              Divider(
                thickness: 5,
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      fightBattle(PokeAction.Attack);
                    },
                    child: Container(
                      width: width*0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        border: Border.all(
                          color: darkBlack,
                          width: 1.5
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                            AppLocalizations.of(context)!.attack_casual_string,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                            )),
                      ),
                    )
                  ),
                  GestureDetector(
                      onTap: (){
                        fightBattle(PokeAction.ElemtalAttack);
                      },
                      child: Container(
                        width: width*0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: darkBlack,
                                width: 1.5
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              AppLocalizations.of(context)!.attack_elemental_string,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: typeColors[currentUserPokemon.pokemon.type.first], fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        ),
                      )
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        fightBattle(PokeAction.Defence);
                      },
                      child: Container(
                        width: width*0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: darkBlack,
                                width: 1.5
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              AppLocalizations.of(context)!.defence_casual_string,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        ),
                      )
                  ),
                  GestureDetector(
                      onTap: (){
                        fightBattle(PokeAction.ElemtalDefence);
                      },
                      child: Container(
                        width: width*0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(
                                color: darkBlack,
                                width: 1.5
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              AppLocalizations.of(context)!.defence_elemental_string,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: typeColors[currentUserPokemon.pokemon.type.first], fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        ),
                      )
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Divider(
                thickness: 5,
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width,
                        child: Text(
                          AppLocalizations.of(context)!.pokeballs_string, textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28, color: darkBlack,
                              fontWeight: FontWeight.w700, decoration: TextDecoration.none),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showPokeball(
                              shopItems[0].itemName,
                              shopItems[0].imagePath,
                              PokeballsTypeCatch.Pokeball,
                              userPokeBalls[0]
                          ),
                          showPokeball(
                              shopItems[1].itemName,
                              shopItems[1].imagePath,
                              PokeballsTypeCatch.Greatball,
                              userPokeBalls[1]
                          ),
                          showPokeball(
                              shopItems[2].itemName,
                              shopItems[2].imagePath,
                              PokeballsTypeCatch.Ultraball,
                              userPokeBalls[2]
                          ),
                          showPokeball(
                              shopItems[3].itemName,
                              shopItems[3].imagePath,
                              PokeballsTypeCatch.Masterball,
                              userPokeBalls[3]
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                  onTap: () async{
                    bool canCatch = false;
                    if(selectedPokeball == PokeballsTypeCatch.Pokeball){
                      if(userPokeBalls[0] >=1){
                        canCatch = true;
                      }
                    }
                    else if(selectedPokeball == PokeballsTypeCatch.Greatball){
                      if(userPokeBalls[1] >=1){
                        canCatch = true;
                      }
                    }
                    else if(selectedPokeball == PokeballsTypeCatch.Ultraball){
                      if(userPokeBalls[2] >=1){
                        canCatch = true;
                      }
                    }
                    else{
                      if(userPokeBalls[3] >=1){
                        canCatch = true;
                      }
                    }
                    if(canCatch == true){
                      await catchPokemonPokeball(selectedPokeball);
                    }
                    else{
                      Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.no_more_pokeballs,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Container(
                    width: width*0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: searchBoxColor,
                        border: Border.all(
                            color: darkBlack,
                            width: 1.5
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.catching_pokemon_outlined, color: Colors.white, size: 36,),
                          const SizedBox(width: 10,),
                          Text(
                              AppLocalizations.of(context)!.catch_string,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )
                          ),
                          const SizedBox(width: 10,),
                          Icon(Icons.catching_pokemon_outlined, color: Colors.white, size: 36,),
                        ],
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ) : Center(
        child: CupertinoActivityIndicator(
          color: colorWater,
          radius: 10,
        ),
      ),
    );
  }
}

