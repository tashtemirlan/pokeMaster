import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokemonmap/Models/pokemonModel.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;

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
  final double _itemWidth = 100.0;
  late List<Pokemon> _shuffledPokemonList;

  int? _selectedIndex;  // Index of the selected Pokémon
  Pokemon? _selectedPokemon;  // To store the selected Pokémon

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animationController.addListener(() {
      _scrollController.jumpTo(_animation.value);
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRoulette();
      }
    });

    // Shuffle the Pokémon list initially
    _shufflePokemonList();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _shufflePokemonList() {
    _shuffledPokemonList = List.from(globals.pokeList)..shuffle();
    _selectedIndex = null;  // Reset the selected Pokémon
    _selectedPokemon = null;  // Reset the selected Pokémon to display
  }

  // Start spinning the roulette
  void _startRoulette() {
    _shufflePokemonList();  // Shuffle Pokémon each time we spin
    setState(() {
      _currentOffset = _scrollController.position.pixels;
    });

    final targetOffset = _currentOffset + _random.nextInt(5000) + 1000;

    _animation = Tween<double>(
      begin: _currentOffset,
      end: targetOffset,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _animationController.forward(from: 0.0);
  }

  // Stop the roulette and highlight the chosen Pokémon
  void _stopRoulette() {
    double finalOffset = _scrollController.position.pixels;
    double remainder = finalOffset % _itemWidth;

    // Align to the nearest Pokémon
    if (remainder > _itemWidth / 2) {
      finalOffset = finalOffset - remainder + _itemWidth;
    } else {
      finalOffset = finalOffset - remainder;
    }

    // Find the selected Pokémon based on the final adjusted offset
    int selectedIndex = (finalOffset ~/ _itemWidth) % _shuffledPokemonList.length;

    setState(() {
      _selectedIndex = selectedIndex;  // Save the index of the chosen Pokémon
      _selectedPokemon = _shuffledPokemonList[selectedIndex];  // Save the chosen Pokémon to display its name
    });

    // Animate to perfectly align the selected Pokémon
    _scrollController.animateTo(
      finalOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            SizedBox(
              height: _itemWidth,  // Set the height for the Pokémon list
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: _shuffledPokemonList.length * 5,  // Loop through the list to simulate endless scroll
                itemBuilder: (context, index) {
                  final pokemon = _shuffledPokemonList[index % _shuffledPokemonList.length];
                  bool isSelected = (index % _shuffledPokemonList.length) == _selectedIndex;

                  return Container(
                    width: _itemWidth,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: globals.showRarityColorPokemon(pokemon.rarity),
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected
                          ? Border.all(color: globals.showRarityColorPokemon(pokemon.rarity), width: 3)
                          : Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          pokemon.gifFront,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          pokemon.name,  // Display Pokémon name
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? globals.showRarityColorPokemon(pokemon.rarity) : Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startRoulette,
              child: Text(
                "Spin the Roulette",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
