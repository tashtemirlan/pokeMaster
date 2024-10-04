import 'package:flutter/material.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:pokemonmap/database_instructions/pokeNames.dart' as pokeNames;
import 'package:pokemonmap/database_instructions/pokeGifs.dart' as pokeGifs;
import 'package:pokemonmap/database_instructions/pokeRarity.dart' as pokeRarity;
import 'package:pokemonmap/database_instructions/pokeRegion.dart' as pokeRegion;
import 'package:pokemonmap/database_instructions/pokeStats.dart' as pokeStats;
import 'package:pokemonmap/database_instructions/pokeTypes.dart' as pokeTypes;
import 'package:pokemonmap/database_instructions/pokeWeakness.dart' as pokeWeakness;
import '../global_folder/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PokemonPokedexBottomSheet extends StatefulWidget{
  final int pokeIndex;
  const PokemonPokedexBottomSheet({super.key, required this.pokeIndex});

  @override
  PokemonPokedexBottomSheetState createState() => PokemonPokedexBottomSheetState();
}

class PokemonPokedexBottomSheetState extends State<PokemonPokedexBottomSheet> {

  String gifPath = "";
  
  @override
  void initState() {
    super.initState();
    if(widget.pokeIndex<99){
      if(widget.pokeIndex<9){
        gifPath = 'assets/gifs/00${widget.pokeIndex + 1}.gif';
      }
      else{
        gifPath = 'assets/gifs/0${widget.pokeIndex + 1}.gif';
      }
    }
    else{
      gifPath = 'assets/gifs/${widget.pokeIndex + 1}.gif';
    }
  }

  Widget showRarityPokemon(Rarity rarity){
    String showRarityString = "";
    if(rarity == Rarity.casual){
        showRarityString = AppLocalizations.of(context)!.poke_rarity_casual;
    }
    else if(rarity == Rarity.rare){
      showRarityString = AppLocalizations.of(context)!.poke_rarity_rare;
    }
    else if(rarity == Rarity.epic){
      showRarityString = AppLocalizations.of(context)!.poke_rarity_epic;
    }
    else if(rarity == Rarity.mystic){
      showRarityString = AppLocalizations.of(context)!.poke_rarity_mystic;
    }
    else{
      showRarityString = AppLocalizations.of(context)!.poke_rarity_legendary;
    }
    return Text(showRarityString);
  }

  Widget showRegionPokemon(Region region){
    String showRegionString = "";
    if(region == Region.Kanto){
      showRegionString = "Kanto";
    }
    else if(region == Region.Johto){
      showRegionString = "Johto";
    }
    else if(region == Region.Hoenn){
      showRegionString = "Hoenn";
    }
    else if(region == Region.Sinnoh){
      showRegionString = "Sinnoh";
    }
    else if(region == Region.Unova){
      showRegionString = "Unova";
    }
    else{
      showRegionString = "Kalos";
    }
    return Text(showRegionString);
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
              Image.asset(
                gifPath,
                height: width *0.6,
                width: width *0.6,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(pokeNames.pokeNames[widget.pokeIndex]),
              const SizedBox(height: 10),
              Wrap(
                spacing: 4,
                children: pokeTypes.pokeType[widget.pokeIndex].map((type) {
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
              const SizedBox(height: 10),
              showRarityPokemon(pokeRarity.pokeRarity[widget.pokeIndex]),
              const SizedBox(height: 10),
              showRegionPokemon(pokeRegion.pokeRegion[widget.pokeIndex])
            ],
          ),
        )
    );
  }
}