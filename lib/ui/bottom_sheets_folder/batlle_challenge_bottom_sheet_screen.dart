import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokemonmap/models/pokeAwards.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeRegion.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart';

import '../../models/pokedexModel.dart';
import '../../models/pokemonFolder/pokeRarity.dart';
import '../../models/pokemonFolder/pokeStats.dart';
import '../../models/pokemonFolder/pokemonModel.dart';
import '../../models/pokemonUser.dart';
import '../global_folder/challenge_masters_folder/pokemon_master_data_class.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../global_folder/globals.dart';


enum PokeAction{
  Attack,
  ElemtalAttack,
  Defence,
  ElemtalDefence,
}

class BattleChallengeBottomSheetScreen extends StatefulWidget{
  final PokemonMasterDataClass pokemonListMasters;
  final PokeAwards pokeAwards;
  final bool isEliteFour;
  final bool isMaster;
  final Region region;
  const BattleChallengeBottomSheetScreen({super.key, required this.pokemonListMasters,
    required this.pokeAwards, required this.isEliteFour, required this.isMaster, required this.region});

  @override
  BattleChallengeBottomSheetScreenState createState() => BattleChallengeBottomSheetScreenState();
}

class BattleChallengeBottomSheetScreenState extends State<BattleChallengeBottomSheetScreen> with TickerProviderStateMixin {
  List<PokemonUser?> userTeam = List.filled(6, null, growable: false);
  List<PokemonTrainer?> opponentTeam = List.filled(6, null, growable: false);
  bool dataGet = false;
  late PokemonUser currentUserPokemon;
  late PokemonTrainer currentOpponentPokemon;
  final Random _randomPokeActions = Random();

  double userSelectedPokemonMaxHp = 0;
  double opponentSelectedPokemonMaxHp = 0;
  double currentHpPokemonUser = 0;
  double currentHpPokemonOpponent = 0;

  double addedShieldCasualUserPokemon =0;
  double addedShieldElementalUserPokemon =0;

  double addedShieldCasualOpponentPokemon = 0;
  double addedShieldElementalOpponentPokemon = 0;


  String textLastMove = "";
  String allLogText = "";

  late AnimationController controllerAnimationUser;
  late AnimationController controllerAnimationOpponent;

  late Animation<Offset> animationImageUser;
  bool animatingImageUser = false;

  late Animation<Offset> animationOpponentPokemon;
  bool animatingOpponentPokemon = false;


  final GlobalKey gifKeyImageUser = GlobalKey();
  final GlobalKey gifKeyImageOpponent = GlobalKey();

  List<String> defeatedUserPokemons = [];
  List<String> defeatedOpponentPokemons = [];

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

  double opponentBasicHp = 0;
  double opponentBasicAttack = 0;
  double opponentBasicDefence = 0;
  double opponentBasicSpAttack = 0;
  double opponentBasicSpDefence = 0;
  double opponentBasicSpeed = 0;

  double opponentUpgradedHp = 0;
  double opponentUpgradedAttack = 0;
  double opponentUpgradedDefence = 0;
  double opponentUpgradedSpAttack = 0;
  double opponentUpgradedSpDefence = 0;
  double opponentUpgradedSpeed = 0;

  List<PokedexPokemonModel> hivePokedexList = [];

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

  Future<void> getOpponentTeamPokemons() async {
    opponentTeam = List.filled(6, null);
    for (int i = 0; i < widget.pokemonListMasters.listPokemonTrainer.length && i < opponentTeam.length; i++) {
      opponentTeam[i] = widget.pokemonListMasters.listPokemonTrainer[i];
    }
    PokemonTrainer pkOpponent = opponentTeam.first!;
    await getNewOpponentPokemon(pkOpponent);
  }

  Future<void> getNewOpponentPokemon(PokemonTrainer pkOpponent) async{
   await setOpponentPokemonData(pkOpponent);
   Pokemon pokemonData = pkOpponent.pokemon;
    Pokemon buffedPokemon = Pokemon(
        pokeDexIndex: pokemonData.pokeDexIndex,
        name: pokemonData.name,
        rarity: pokemonData.rarity,
        type: pokemonData.type,
        pokeStats: PokeStats(
            hp: opponentUpgradedHp,
            attack: opponentUpgradedAttack,
            defence: opponentUpgradedDefence,
            specialAttack: opponentUpgradedSpAttack,
            specialDefence: opponentUpgradedSpDefence,
            speed: opponentUpgradedSpeed),
        region: pokemonData.region,
        weakness: pokemonData.weakness,
        gifFront: pokemonData.gifFront,
        gifBack: pokemonData.gifBack);
    PokemonTrainer buffedPokemonWld = PokemonTrainer(pokemon: buffedPokemon, lvl: pkOpponent.lvl, hashPokemonTrainer: pkOpponent.hashPokemonTrainer);
    setState(() {
      currentOpponentPokemon = buffedPokemonWld;
      opponentSelectedPokemonMaxHp = buffedPokemonWld.pokemon.pokeStats.hp;
      currentHpPokemonOpponent = buffedPokemonWld.pokemon.pokeStats.hp;
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

  Future<void> setOpponentPokemonData(PokemonTrainer pkOpponent) async{
    final pokemon_pokmonUser = pkOpponent.pokemon;

    late Pokemon pokemonFromPokedex;
    for(int i=0; i<hivePokedexList.length; i++){
      if(hivePokedexList[i].pokemon.name == pokemon_pokmonUser.name){
        pokemonFromPokedex = hivePokedexList[i].pokemon;
        break;
      }
    }

    opponentBasicHp = pokemonFromPokedex.pokeStats.hp;
    opponentBasicAttack = pokemonFromPokedex.pokeStats.attack;
    opponentBasicDefence = pokemonFromPokedex.pokeStats.defence;
    opponentBasicSpAttack = pokemonFromPokedex.pokeStats.specialAttack;
    opponentBasicSpDefence = pokemonFromPokedex.pokeStats.specialDefence;
    opponentBasicSpeed = pokemonFromPokedex.pokeStats.speed;

    if(pokemon_pokmonUser.rarity == Rarity.casual){
      opponentUpgradedHp = pokemonFromPokedex.pokeStats.hp + 2*(pkOpponent.lvl-1);
      opponentUpgradedAttack = pokemonFromPokedex.pokeStats.attack + (pkOpponent.lvl-1);
      opponentUpgradedDefence = pokemonFromPokedex.pokeStats.defence + (pkOpponent.lvl-1);
      opponentUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + (pkOpponent.lvl-1);
      opponentUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + (pkOpponent.lvl-1);
      opponentUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + (pkOpponent.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.rare){
      opponentUpgradedHp = pokemonFromPokedex.pokeStats.hp + 3*(pkOpponent.lvl-1);
      opponentUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 2*(pkOpponent.lvl-1);
      opponentUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 2*(pkOpponent.lvl-1);
      opponentUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 2*(pkOpponent.lvl-1);
      opponentUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 2*(pkOpponent.lvl-1);
      opponentUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 2*(pkOpponent.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.epic){
      opponentUpgradedHp = pokemonFromPokedex.pokeStats.hp + 4*(pkOpponent.lvl-1);
      opponentUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 3*(pkOpponent.lvl-1);
      opponentUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 3*(pkOpponent.lvl-1);
      opponentUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 3*(pkOpponent.lvl-1);
      opponentUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 3*(pkOpponent.lvl-1);
      opponentUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 3*(pkOpponent.lvl-1);
    }
    else if(pokemon_pokmonUser.rarity == Rarity.mystic){
      opponentUpgradedHp = pokemonFromPokedex.pokeStats.hp + 5*(pkOpponent.lvl-1);
      opponentUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 4*(pkOpponent.lvl-1);
      opponentUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 4*(pkOpponent.lvl-1);
      opponentUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 4*(pkOpponent.lvl-1);
      opponentUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 4*(pkOpponent.lvl-1);
      opponentUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 4*(pkOpponent.lvl-1);
    }
    else{
      opponentUpgradedHp = pokemonFromPokedex.pokeStats.hp + 7*(pkOpponent.lvl-1);
      opponentUpgradedAttack = pokemonFromPokedex.pokeStats.attack + 5*(pkOpponent.lvl-1);
      opponentUpgradedDefence = pokemonFromPokedex.pokeStats.defence + 5*(pkOpponent.lvl-1);
      opponentUpgradedSpAttack = pokemonFromPokedex.pokeStats.specialAttack + 5*(pkOpponent.lvl-1);
      opponentUpgradedSpDefence = pokemonFromPokedex.pokeStats.specialDefence + 5*(pkOpponent.lvl-1);
      opponentUpgradedSpeed = pokemonFromPokedex.pokeStats.speed + 5*(pkOpponent.lvl-1);
    }
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

  Future<void> getAnotherOpponentPokemon() async{
    //we should add current user pokemonto defeated list =>
    defeatedOpponentPokemons.add(currentOpponentPokemon.hashPokemonTrainer);
    bool opponentHaveAnotherPokemon = false;
    //We need to work with all users team :
    for(int i=0; i<opponentTeam.length; i++){
      final potentialPokemon = opponentTeam[i];
      if (potentialPokemon != null && !defeatedOpponentPokemons.contains(potentialPokemon.hashPokemonTrainer)) {
        // If we find a valid Pokémon not in the defeated list, use it
        await setOpponentPokemonData(potentialPokemon);
        await getNewOpponentPokemon(potentialPokemon);
        setState(() {
          opponentHaveAnotherPokemon = true;
        });
        break;
      }
    }
    //Now check logic if user had any pokemon :
    if(opponentHaveAnotherPokemon == false){
      //show alert with one option to leave location in future, current just toast =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(AppLocalizations.of(context)!.win_string,
                    style: const TextStyle(
                        fontSize: 18, color: CupertinoColors.black, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                    ))
              ],
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.challenge_overcome_string, textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, color: CupertinoColors.black, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                    )),
                SizedBox(height: 20,),
                Text(AppLocalizations.of(context)!.you_got_string,
                    style: const TextStyle(
                        fontSize: 18, color: CupertinoColors.black, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                    )),
                SizedBox(height: 10,),
                Image.asset(
                  widget.pokeAwards.awardImagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10,),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async{
                        await registerBadgeChallenge();
                        Navigator.pop(context); // Close the dialog
                        Navigator.pop(context); // Exit the battle
                        Navigator.pop(context, "Update"); //Exit challenge
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

  Future<void> registerBadgeChallenge() async{
    var box = await Hive.openBox("PokemonUserDataBase");
    if(widget.isMaster == true){
      //We need to work with master badge
      List<dynamic> pokeListMasterAwards = box.get("PokeChallengeMaster", defaultValue: []);
      List<PokeAwards> pokeMasterList = pokeListMasterAwards.map((dynamic item) {
        return item as PokeAwards; // Cast each item to PokeAwards
      }).toList();
      int indexAwardsWhere = pokeMasterList.indexWhere(
              (data) => data == widget.pokeAwards
      );
      if(indexAwardsWhere !=-1){
        pokeMasterList[indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeMaster", pokeMasterList);
      }
    }
    else if(widget.isEliteFour == true){
      //We need to work with elite four badge
      List<dynamic> pokeListEliteFourAwards = box.get("PokeChallengeElite", defaultValue: []);
      // Create a new List<List<PokeAwards>> by safely casting each sublist
      List<List<PokeAwards>> pokeListEliteFourFromHive = pokeListEliteFourAwards.map((dynamic sublist) {
        return (sublist as List).map((dynamic item) {
          return item as PokeAwards;  // Cast each item to PokeAwards
        }).toList();
      }).toList();

      if(widget.region == Region.Kanto){
        int indexAwardsWhere = pokeListEliteFourFromHive[0].indexWhere((data) => data == widget.pokeAwards);
        pokeListEliteFourFromHive[0][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeElite", pokeListEliteFourFromHive);
      }
      else if(widget.region == Region.Johto){
        int indexAwardsWhere = pokeListEliteFourFromHive[1].indexWhere((data) => data == widget.pokeAwards);
        pokeListEliteFourFromHive[1][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeElite", pokeListEliteFourFromHive);
      }
      else if(widget.region == Region.Hoenn){
        int indexAwardsWhere = pokeListEliteFourFromHive[2].indexWhere((data) => data == widget.pokeAwards);
        pokeListEliteFourFromHive[2][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeElite", pokeListEliteFourFromHive);
      }
      else if(widget.region == Region.Sinnoh){
        int indexAwardsWhere = pokeListEliteFourFromHive[3].indexWhere((data) => data == widget.pokeAwards);
        pokeListEliteFourFromHive[3][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeElite", pokeListEliteFourFromHive);
      }
      else if(widget.region == Region.Unova){
        int indexAwardsWhere = pokeListEliteFourFromHive[4].indexWhere((data) => data == widget.pokeAwards);
        pokeListEliteFourFromHive[4][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeElite", pokeListEliteFourFromHive);
      }
      else if(widget.region == Region.Kalos){
        int indexAwardsWhere = pokeListEliteFourFromHive[5].indexWhere((data) => data == widget.pokeAwards);
        pokeListEliteFourFromHive[5][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallengeElite", pokeListEliteFourFromHive);
      }
      else{
        //Todo : => do nothing
      }
    }
    else{
      //just casual gym :
      List<dynamic> pokeListAwards = box.get("PokeChallenge", defaultValue: []);
      List<List<PokeAwards>> pokeListFromHive = pokeListAwards.map((dynamic sublist) {
        return (sublist as List).map((dynamic item) {
          return item as PokeAwards;  // Cast each item to PokeAwards
        }).toList();
      }).toList();

      if(widget.region == Region.Kanto){
        int indexAwardsWhere = pokeListFromHive[0].indexWhere((data) => data == widget.pokeAwards);
        pokeListFromHive[0][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallenge", pokeListFromHive);
      }
      else if(widget.region == Region.Johto){
        int indexAwardsWhere = pokeListFromHive[1].indexWhere((data) => data == widget.pokeAwards);
        pokeListFromHive[1][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallenge", pokeListFromHive);
      }
      else if(widget.region == Region.Hoenn){
        int indexAwardsWhere = pokeListFromHive[2].indexWhere((data) => data == widget.pokeAwards);
        pokeListFromHive[2][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallenge", pokeListFromHive);
      }
      else if(widget.region == Region.Sinnoh){
        int indexAwardsWhere = pokeListFromHive[3].indexWhere((data) => data == widget.pokeAwards);
        pokeListFromHive[3][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallenge", pokeListFromHive);
      }
      else if(widget.region == Region.Unova){
        int indexAwardsWhere = pokeListFromHive[4].indexWhere((data) => data == widget.pokeAwards);
        pokeListFromHive[4][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallenge", pokeListFromHive);
      }
      else if(widget.region == Region.Kalos){
        int indexAwardsWhere = pokeListFromHive[5].indexWhere((data) => data == widget.pokeAwards);
        pokeListFromHive[5][indexAwardsWhere] = PokeAwards(awardImagePath: widget.pokeAwards.awardImagePath, obtained: true, awardName: widget.pokeAwards.awardName, cityName: widget.pokeAwards.cityName);
        //update data =>
        box.put("PokeChallenge", pokeListFromHive);
      }
      else{
        //Todo : => do nothing
      }
    }
  }

  // Method to trigger animation
  Future<void> triggerFightAnimationUser() async{
    await controllerAnimationUser.forward().then((_) => controllerAnimationUser.reverse());
  }

  Future<void> triggerFightAnimationWild() async{
    await controllerAnimationOpponent.forward().then((_) => controllerAnimationOpponent.reverse());
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
    setState(() {
      textLastMove = "$pokemonName ${AppLocalizations.of(context)!.used_string} ${getNameAttack(pokeAction)}";
    });
    if(allLogText.isEmpty){ allLogText = textLastMove;}
    else{allLogText = "$allLogText\n$textLastMove";}
  }

  Future<void> userPokemonFight(PokeAction pokeAction) async{
    //User firstly beat by his own move.
    if(pokeAction == PokeAction.Defence || pokeAction == PokeAction.ElemtalDefence){
      //We shouldn't animateaction
      addRecordDescripton(pokeAction, currentUserPokemon.pokemon.name);
      if(pokeAction == PokeAction.Defence){
        setState(() {
          addedShieldCasualUserPokemon = currentUserPokemon.pokemon.pokeStats.defence / 2;
        });
      }
      else if(pokeAction == PokeAction.ElemtalDefence){
        setState(() {
          addedShieldElementalUserPokemon = currentUserPokemon.pokemon.pokeStats.specialDefence / 2;
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
        final minusHp = (currentOpponentPokemon.pokemon.pokeStats.defence/2 - currentUserPokemon.pokemon.pokeStats.attack);
        if(minusHp >= 0){
          // that means wild pokemon shield is higher then our attack
          final result = currentHpPokemonOpponent - 5;
          setState(() {
            currentHpPokemonOpponent = result;
          });
        }
        else{
          //If our attack is higher then wild pokemon defence then we should minus our rest of attack with shield power
          final shieldMinusHp = addedShieldCasualOpponentPokemon + minusHp;
          if(shieldMinusHp >=0){
            //If overall shield protect then do nothing
            final result = currentHpPokemonOpponent -10;
            setState(() {
              currentHpPokemonOpponent = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            final result = currentHpPokemonOpponent + shieldMinusHp;
            if(result <=0){
              setState(() {
                currentHpPokemonOpponent = 0;
              });
            }
            else{
              setState(() {
                currentHpPokemonOpponent = result;
              });
            }
          }
        }
      }
      else{
        // If elemental attack we should check if pokemon hve weakness against this type=>
        final minusHp = currentOpponentPokemon.pokemon.pokeStats.specialDefence *0.75 - currentUserPokemon.pokemon.pokeStats.specialAttack;

        if(minusHp >= 0){
          // that means wild pokemon shield is higher then our attack
          final result = currentHpPokemonOpponent - 5;
          setState(() {
            currentHpPokemonOpponent = result;
          });
        }
        else{
          //If our attack is higher then wild pokemon defence then we should minus our rest of attack with shield power
          final shieldMinusHp = addedShieldElementalOpponentPokemon + minusHp;
          if(shieldMinusHp >=0){
            //If overall shield protect then do nothing
            final result = currentHpPokemonOpponent -10;
            setState(() {
              currentHpPokemonOpponent = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            if(currentOpponentPokemon.pokemon.weakness.contains(currentUserPokemon.pokemon.type.first)){
              final result = currentHpPokemonOpponent + shieldMinusHp * 2;
              if(result <=0){
                setState(() {
                  currentHpPokemonOpponent = 0;
                });
              }
              else{
                setState(() {
                  currentHpPokemonOpponent = result;
                });
              }
            }
            else{
              //pokemon don't have weakness against this type :
              final result = currentHpPokemonOpponent + shieldMinusHp;
              if(result <=0){
                setState(() {
                  currentHpPokemonOpponent = 0;
                });
              }
              else{
                setState(() {
                  currentHpPokemonOpponent = result;
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
      addRecordDescripton(wildPokemonAction, currentOpponentPokemon.pokemon.name);
      if(wildPokemonAction == PokeAction.Defence){
        setState(() {
          addedShieldCasualOpponentPokemon = currentOpponentPokemon.pokemon.pokeStats.defence / 2;
        });
      }
      else{
        setState(() {
          addedShieldElementalOpponentPokemon = currentOpponentPokemon.pokemon.pokeStats.specialDefence / 2;
        });
      }
    }
    else{
      setState(() {
        animatingOpponentPokemon = true;
      });
      await triggerFightAnimationWild();
      addRecordDescripton(wildPokemonAction, currentOpponentPokemon.pokemon.name);
      setState(() {
        animatingOpponentPokemon = false;
      });
      //Update users pokemon health.
      if(wildPokemonAction == PokeAction.Attack){
        //If attack we minus constant value=>
        final minusHp = currentUserPokemon.pokemon.pokeStats.defence/2 - currentOpponentPokemon.pokemon.pokeStats.attack;

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
        final minusHp = currentUserPokemon.pokemon.pokeStats.specialDefence *0.75 - currentOpponentPokemon.pokemon.pokeStats.specialAttack;

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
            final result = currentHpPokemonUser -10;
            setState(() {
              currentHpPokemonUser = result;
            });
          }
          else{
            //If shield can't defence then we should minune that value :
            if(currentUserPokemon.pokemon.weakness.contains(currentOpponentPokemon.pokemon.type.first)){
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

  Future<void> fightBattle(PokeAction pokeAction) async{
    //So we are work like :
    if(animatingImageUser == true || animatingOpponentPokemon == true){
      //TODO : DO NOTHING IF THEY ARE STILL FIGHT
    }
    else{
      //User pokemon fight
      await userPokemonFight(pokeAction);
      //Then we should check if wild pokemon hp is lower or equal to 0 :
      if(currentHpPokemonOpponent <=0){
        //Then pokemon should fainted :
        await getAnotherOpponentPokemon();
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

    controllerAnimationOpponent = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation duration
    );

    // Define the offset animation for small movement
    animationOpponentPokemon = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-20, 20), // Small up-right movement
    ).animate(CurvedAnimation(parent: controllerAnimationOpponent, curve: Curves.easeInOut));
  }

  Future<void> initVoid() async{
    await setDataFromHivePokedexInitialized();
    //Get users pokemons team
    await getUserTeamPokemons();
    //get opponent pokemon
    await getOpponentTeamPokemons();
    //setup animations :
    await setupAnimations();
    setState(() {
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
    controllerAnimationOpponent.dispose();
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
              const SizedBox(height: 30,),
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
                        ],
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 70),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                            animation: animationOpponentPokemon,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: animationOpponentPokemon.value,
                                child: child,
                              );
                            },
                            child: Image.asset(
                              currentOpponentPokemon.pokemon.gifFront,
                              key: gifKeyImageOpponent,
                              height: 120,
                              width: 120,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.contain,
                            )
                        ),
                        const SizedBox(height: 5,),
                        Text(
                            showPokemonNameCyrillic(currentOpponentPokemon.pokemon.name),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                            )
                        ),
                        const SizedBox(height: 3,),
                        Text(
                            "Lvl. ${currentOpponentPokemon.lvl}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, color: darkBlack, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                            )
                        ),
                        const SizedBox(height: 5,),
                        LinearPercentIndicator(
                          width: 140.0,
                          lineHeight: 14.0,
                          percent: currentHpPokemonOpponent/opponentSelectedPokemonMaxHp,
                          center: Text(
                            "$currentHpPokemonOpponent/$opponentSelectedPokemonMaxHp",
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