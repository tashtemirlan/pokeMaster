import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/bottom_sheets_folder/pokemon_pokedex_bottom_sheet.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../../models/pokemonFolder/pokeRarity.dart';


class PokemonRouletteBottomSheet extends StatefulWidget {
  const PokemonRouletteBottomSheet({super.key});

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
  double _itemWidth = 120;
  int randomVal = 0;


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

    setState(() {
      hiveList = pokeListFromHive;
    });
    
    _shufflePokemonList();
  }

  String showPokemonNameCyrillic(String englishPokeName) {
    // Mapping of English letters to Cyrillic equivalents (basic transliteration)
    final Map<String, String> transliterationMap = {
      'A': 'А', 'B': 'Б', 'C': 'С', 'D': 'Д', 'E': 'Е', 'F': 'Ф', 'G': 'Г',
      'H': 'Х', 'I': 'И', 'J': 'Й', 'K': 'К', 'L': 'Л', 'M': 'М', 'N': 'Н',
      'O': 'О', 'P': 'П', 'Q': 'К', 'R': 'Р', 'S': 'С', 'T': 'Т', 'U': 'У',
      'V': 'В', 'W': 'В', 'X': 'Кс', 'Y': 'Ы', 'Z': 'З',
      'a': 'а', 'b': 'б', 'c': 'с', 'd': 'д', 'e': 'е', 'f': 'ф', 'g': 'г',
      'h': 'х', 'i': 'и', 'j': 'й', 'k': 'к', 'l': 'л', 'm': 'м', 'n': 'н',
      'o': 'о', 'p': 'п', 'q': 'к', 'r': 'р', 's': 'с', 't': 'т', 'u': 'у',
      'v': 'в', 'w': 'в', 'x': 'кс', 'y': 'ы', 'z': 'з'
    };

    String locale = Platform.localeName;
    String languageCode = locale.split('_')[0];

    if (languageCode == 'en') {
      return englishPokeName;
    } else {
      String cyrillicName = englishPokeName.split('').map((letter) {
        return transliterationMap[letter] ?? letter; // Use the mapped letter or fallback to the original
      }).join('');
      return cyrillicName;
    }
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

  void _startRoulette() {
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

  void _stopRoulette() {
    int pokeRandomIndex = hiveList.indexOf(_shuffledPokemonList[randomVal+1]);
    viewPokeBottomSheet(pokeRandomIndex);
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
              child: Text(
                AppLocalizations.of(context)!.spin_roulette_string,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
