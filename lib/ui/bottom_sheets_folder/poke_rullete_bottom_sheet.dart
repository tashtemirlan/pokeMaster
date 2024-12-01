import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/bottom_sheets_folder/pokemon_pokedex_bottom_sheet.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../../models/pokedexModel.dart';
import '../../models/pokemonFolder/pokeRarity.dart';
import '../../models/pokemonUser.dart';
import '../global_folder/globals.dart';


class PokemonRouletteBottomSheet extends StatefulWidget {
  final int typeId;
  final int cost;
  const PokemonRouletteBottomSheet({super.key, required this.typeId , required this.cost});

  @override
  PokemonRouletteBottomSheetState createState() =>
      PokemonRouletteBottomSheetState();
}

class PokemonRouletteBottomSheetState extends State<PokemonRouletteBottomSheet> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  final Random _random = Random();
  double _currentOffset = 0;
  List<Pokemon> _shuffledPokemonList = [];
  List<Pokemon> hiveList = [];
  List<Pokemon> allPokemons = [];
  double _itemWidth = 120;
  int randomVal = 0;

  int showUserMoney = 0;

  Widget listRarity(double width){
    return SizedBox(
      height: (40 * globals.listRarity.length).toDouble(),
      child: ListView.builder(
        itemCount: globals.listRarity.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return SizedBox(
            width: width,
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text(
                  globals.showRarityPokemon(globals.listRarity[index], context),
                  style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                )),
                const SizedBox(width: 10,),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      color: globals.showRarityColorPokemon(globals.listRarity[index]),
                      borderRadius: BorderRadius.circular(5)
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> setDataFromHivePokedexInitialized() async{
    var box = await Hive.openBox("PokemonUserPokedex");
    // Read the list from Hive and cast it to List<Pokemons>
    List<dynamic> pokeListFromHiveDynamic = box.get("Pokemons", defaultValue: []);

    // Cast the list to List<Pokemons>
    List<Pokemon> pokeListFromHive = pokeListFromHiveDynamic.cast<Pokemon>();

    //Todo : set all pokemons :
    allPokemons = pokeListFromHive;

    //Todo : => 1 - all pokemons ; 2 - common pokemons ; 3 - rare pokemons ; 4 - epic pokemons; 5 - mystic pokemons; 6 - legendary pokemons
    if(widget.typeId == 1){
      setState(() {
        hiveList = pokeListFromHive;
      });
    }
    else if(widget.typeId == 2){
      for(int a=0 ; a<pokeListFromHive.length; a++){
        Pokemon pokeFromHive = pokeListFromHive[a];
        if(pokeFromHive.rarity == Rarity.casual){
          hiveList.add(pokeFromHive);
        }
      }
    }
    else if(widget.typeId == 3){
      for(int a=0 ; a<pokeListFromHive.length; a++){
        Pokemon pokeFromHive = pokeListFromHive[a];
        if(pokeFromHive.rarity == Rarity.rare){
          hiveList.add(pokeFromHive);
        }
      }
    }
    else if(widget.typeId == 4){
      for(int a=0 ; a<pokeListFromHive.length; a++){
        Pokemon pokeFromHive = pokeListFromHive[a];
        if(pokeFromHive.rarity == Rarity.epic){
          hiveList.add(pokeFromHive);
        }
      }
    }
    else if(widget.typeId == 5){
      for(int a=0 ; a<pokeListFromHive.length; a++){
        Pokemon pokeFromHive = pokeListFromHive[a];
        if(pokeFromHive.rarity == Rarity.mystic){
          hiveList.add(pokeFromHive);
        }
      }
    }
    else if(widget.typeId == 6){
      for(int a=0 ; a<pokeListFromHive.length; a++){
        Pokemon pokeFromHive = pokeListFromHive[a];
        if(pokeFromHive.rarity == Rarity.legendary){
          hiveList.add(pokeFromHive);
        }
      }
    }
    else{
      setState(() {
        hiveList = pokeListFromHive;
      });
    }
    _shufflePokemonList();
  }

  Future<void> getUserCoins() async{
    var box = await Hive.openBox("PokemonUserDataBase");
    int userCoins = box.get("UserMoneys", defaultValue: 0);
    setState(() {
      showUserMoney = userCoins;
    });
  }

  Future<void> payForRullete() async{
    var box = await Hive.openBox("PokemonUserDataBase");
    int userCoins = showUserMoney - widget.cost;
    await box.put("UserMoneys", userCoins);
    setState(() {
      showUserMoney = userCoins;
    });
  }

  Future<void> addPokemonToUserCollection(Pokemon pokemon) async{
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
        hashId: "${year}_${month}_${day}_${minute}_${second}_${pokemon.name}",
        pokemonExp: 0
    );
    pokeListFromHive.add(firstPokemon);
    await box.put("PokeUserInventory", pokeListFromHive);

    //set this pokemon found in pokedex =>
    for(int i=0; i<pokeListFromHive1.length; i++){
      if(pokeListFromHive1[i].pokemon.name == pokemon.name){
        pokeListFromHive1[i] = PokedexPokemonModel(pokemon: pokemon, isFound: true);
        break;
      }
    }
    await box1.put("Pokedex", pokeListFromHive1);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() {
      _scrollController.jumpTo(_animation.value);
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRoulette();
      }
    });

    setDataFromHivePokedexInitialized();
    getUserCoins();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void viewPokeBottomSheet(int pokeIndex) async{
    showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonPokedexBottomSheet(pokeIndex: pokeIndex, showFind: true,);
      },
    );
  }

  void _shufflePokemonList() {
    _shuffledPokemonList = List.from(hiveList)..shuffle();
  }

  void _startRoulette() async{
    await payForRullete();
    setState(() {
      _currentOffset = 0;
    });

    randomVal = _random.nextInt(hiveList.length);
    final randomValToPixels = randomVal * (_itemWidth.toInt()+10);
    final targetOffset = _currentOffset + randomValToPixels - 10;

    _animation = Tween<double>(
      begin: _currentOffset,
      end: targetOffset,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _animationController.forward(from: 0.0);
  }

  void _stopRoulette() async{
    int pokeRandomIndex = hiveList.indexOf(_shuffledPokemonList[randomVal+1]);
    await addPokemonToUserCollection(hiveList[pokeRandomIndex]);
    int pokemonIndexPokedex = allPokemons.indexOf(hiveList[pokeRandomIndex]);
    viewPokeBottomSheet(pokemonIndexPokedex);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "$showUserMoney",
                    style: TextStyle(fontSize: 22, color: Colors.grey[600],
                        fontWeight: FontWeight.w700, decoration: TextDecoration.none),
                  ),
                  const SizedBox(width: 5,),
                  FaIcon(FontAwesomeIcons.coins , color: colors.goldColor, size: 16,)
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              AppLocalizations.of(context)!.spin_roulette_string,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 150,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _shuffledPokemonList.length * 5,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final pokemon = _shuffledPokemonList[index % _shuffledPokemonList.length];
                  return Padding(
                      padding: EdgeInsets.only(left: index==0 ? 0:10),
                      child: Container(
                        width: _itemWidth,
                        decoration: BoxDecoration(
                          color: globals.showRarityColorPokemon(pokemon.rarity),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              pokemon.gifFront,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              showPokemonNameCyrillic(pokemon.name),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (pokemon.rarity == Rarity.mystic || pokemon.rarity == Rarity.legendary)?
                                Colors.black : Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.rarity_string,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
            SizedBox(height: 10,),
            listRarity(width),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: ()=> _startRoulette(),
              style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(colors.searchBoxColor)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.spin_roulette_string,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Text(
                    "${widget.cost}",
                    style: TextStyle(fontSize: 32, color: Colors.white,
                        fontWeight: FontWeight.w700, decoration: TextDecoration.none),
                  ),
                  const SizedBox(width: 5,),
                  FaIcon(FontAwesomeIcons.coins , color: colors.goldColor, size: 16,)
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
