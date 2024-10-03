import 'package:flutter/material.dart';
import 'package:pokemonmap/UI/GlobalFolder/colors.dart' as colors;
import 'package:pokemonmap/UI/GlobalFolder/globals.dart';

import 'package:pokemonmap/DatabaseInstructions/pokeNames.dart' as pokeNames;
import 'package:pokemonmap/DatabaseInstructions/pokeGifs.dart' as pokeGifs;
import 'package:pokemonmap/DatabaseInstructions/pokeTypes.dart' as pokeTypes;



class PokedexPage extends StatefulWidget{
  const PokedexPage({super.key});

  @override
  PokedexPageState createState ()=> PokedexPageState();

}

class PokedexPageState extends State<PokedexPage>{

  Map<Type, Color> typeColors = {
    Type.Normal: colors.colorNormal,
    Type.Fire: colors.colorFire,
    Type.Water: colors.colorWater,
    Type.Electric: colors.colorElectric,
    Type.Grass: colors.colorGrass,
    Type.Ice: colors.colorIce,
    Type.Fighting: colors.colorFighting,
    Type.Poison: colors.colorPoison,
    Type.Ground: colors.colorGround,
    Type.Flying: colors.colorFlying,
    Type.Psychic: colors.colorPsychic,
    Type.Bug: colors.colorBug,
    Type.Rock: colors.colorRock,
    Type.Ghost: colors.colorGhost,
    Type.Dragon: colors.colorDragon,
    Type.Dark: colors.colorDark,
    Type.Steel: colors.colorSteel,
    Type.Fairy: colors.colorFairy,
  };

  Widget pokeDexPokemon(int index) {
    String pokemonName = pokeNames.pokeNames[index];
    List<Type> types = pokeTypes.pokeType[index];
    String gifPath = "";
    if(index<99){
      if(index<9){
        gifPath = 'assets/gifs/00${index + 1}.gif';
      }
      else{
        gifPath = 'assets/gifs/0${index + 1}.gif';
      }
    }
    else{
      gifPath = 'assets/gifs/${index + 1}.gif';
    }

    // Background color based on primary type
    Color backgroundColor = typeColors[types[0]] ?? Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pokémon GIF
          Image.asset(
            gifPath,
            height: 60,
            width: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          // Pokémon Name
          Text(
            pokemonName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          // Pokémon Types
          Wrap(
            spacing: 4,
            children: types.map((type) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:  typeColors[type] ?? Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1
                  )
                ),
                child: Text(
                  type.toString().split('.').last, // Display type name
                  style:  TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

// Widget to display the Pokémon in a grid with 3 in a row
  Widget pokeDexList(double width) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: pokeNames.pokeNames.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return pokeDexPokemon(index); // Create each Pokémon widget
      },
    );
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
                  child: pokeDexList(width),
              ),
          )
        )
    );
  }

}