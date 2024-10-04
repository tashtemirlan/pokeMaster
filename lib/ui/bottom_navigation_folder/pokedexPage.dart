import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import 'package:pokemonmap/database_instructions/pokeNames.dart' as pokeNames;
import 'package:pokemonmap/database_instructions/pokeGifs.dart' as pokeGifs;
import 'package:pokemonmap/database_instructions/pokeTypes.dart' as pokeTypes;

import '../bottom_sheets_folder/pokemon_pokedex_bottom_sheet.dart';
import '../global_folder/globals.dart';



class PokedexPage extends StatefulWidget{
  const PokedexPage({super.key});

  @override
  PokedexPageState createState ()=> PokedexPageState();

}

class PokedexPageState extends State<PokedexPage>{



  void viewPokeBottomSheet(int pokeIndex) async{
    showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonPokedexBottomSheet(pokeIndex: pokeIndex);
      },
    );
  }

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

    return GestureDetector(
      onTap: (){
          viewPokeBottomSheet(index);
      },
      child: Container(
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
              spacing: 2,
              children: types.map((type) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      color:  typeColors[type] ?? Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1
                      )
                  ),
                  child: Text(
                    type.toString().split('.').last,
                    style:  TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

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