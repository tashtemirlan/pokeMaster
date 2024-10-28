library pokemon.globals;

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pokemonmap/models/pokemonFolder/pokemonModel.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/pokemonFolder/pokeRegion.dart';
import '../../models/pokemonFolder/pokeType.dart';
import '../../models/pokemonFolder/pokeRarity.dart';

List<PokeType> listTypes = [
  PokeType.Normal,
  PokeType.Fire,
  PokeType.Water,
  PokeType.Electric,
  PokeType.Grass,
  PokeType.Ice,
  PokeType.Fighting,
  PokeType.Poison,
  PokeType.Ground,
  PokeType.Flying,
  PokeType.Psychic,
  PokeType.Bug,
  PokeType.Rock,
  PokeType.Ghost,
  PokeType.Dragon,
  PokeType.Dark,
  PokeType.Steel,
  PokeType.Fairy
];

List<Rarity> listRarity = [
  Rarity.casual,
  Rarity.rare,
  Rarity.epic,
  Rarity.mystic,
  Rarity.legendary
];

List<Region> listRegions = [
  Region.Kanto,
  Region.Johto,
  Region.Hoenn,
  Region.Sinnoh,
  Region.Unova,
  Region.Kalos
];

Map<PokeType, Color> typeColors = {
  PokeType.Normal: colors.colorNormal,
  PokeType.Fire: colors.colorFire,
  PokeType.Water: colors.colorWater,
  PokeType.Electric: colors.colorElectric,
  PokeType.Grass: colors.colorGrass,
  PokeType.Ice: colors.colorIce,
  PokeType.Fighting: colors.colorFighting,
  PokeType.Poison: colors.colorPoison,
  PokeType.Ground: colors.colorGround,
  PokeType.Flying: colors.colorFlying,
  PokeType.Psychic: colors.colorPsychic,
  PokeType.Bug: colors.colorBug,
  PokeType.Rock: colors.colorRock,
  PokeType.Ghost: colors.colorGhost,
  PokeType.Dragon: colors.colorDragon,
  PokeType.Dark: colors.colorDark,
  PokeType.Steel: colors.colorSteel,
  PokeType.Fairy: colors.colorFairy,
};

String showRarityPokemon(Rarity rarity, BuildContext context){
  if(rarity == Rarity.casual){
    return AppLocalizations.of(context)!.poke_rarity_casual;
  }
  else if(rarity == Rarity.rare){
    return AppLocalizations.of(context)!.poke_rarity_rare;
  }
  else if(rarity == Rarity.epic){
    return AppLocalizations.of(context)!.poke_rarity_epic;
  }
  else if(rarity == Rarity.mystic){
    return AppLocalizations.of(context)!.poke_rarity_mystic;
  }
  else{
    return AppLocalizations.of(context)!.poke_rarity_legendary;
  }
}

String showRegionPokemon(Region region,BuildContext context){
  if(region == Region.Kanto){
    return  AppLocalizations.of(context)!.region_kanto;
  }
  else if(region == Region.Johto){
    return  AppLocalizations.of(context)!.region_johto;
  }
  else if(region == Region.Hoenn){
    return  AppLocalizations.of(context)!.region_hoenn;
  }
  else if(region == Region.Sinnoh){
    return  AppLocalizations.of(context)!.region_sinnoh;
  }
  else if(region == Region.Unova){
    return  AppLocalizations.of(context)!.region_unova;
  }
  else{
    return  AppLocalizations.of(context)!.region_kalos;
  }
}

String showTypePokemon(PokeType type, BuildContext context){
  if(type == PokeType.Normal){
    return AppLocalizations.of(context)!.pokemon_type_normal;
  }
  else if(type == PokeType.Fire){
    return AppLocalizations.of(context)!.pokemon_type_fire;
  }
  else if(type == PokeType.Water){
    return AppLocalizations.of(context)!.pokemon_type_water;
  }
  else if(type == PokeType.Electric){
    return AppLocalizations.of(context)!.pokemon_type_electric;
  }
  else if(type == PokeType.Grass){
    return AppLocalizations.of(context)!.pokemon_type_grass;
  }
  else if(type == PokeType.Ice){
    return AppLocalizations.of(context)!.pokemon_type_ice;
  }
  else if(type == PokeType.Fighting){
    return AppLocalizations.of(context)!.pokemon_type_fighting;
  }
  else if(type == PokeType.Poison){
    return AppLocalizations.of(context)!.pokemon_type_poison;
  }
  else if(type == PokeType.Ground){
    return AppLocalizations.of(context)!.pokemon_type_ground;
  }
  else if(type == PokeType.Flying){
    return AppLocalizations.of(context)!.pokemon_type_flying;
  }
  else if(type == PokeType.Psychic){
    return AppLocalizations.of(context)!.pokemon_type_psychic;
  }
  else if(type == PokeType.Bug){
    return AppLocalizations.of(context)!.pokemon_type_bug;
  }
  else if(type == PokeType.Ghost){
    return AppLocalizations.of(context)!.pokemon_type_ghost;
  }
  else if(type == PokeType.Dragon){
    return AppLocalizations.of(context)!.pokemon_type_dragon;
  }
  else if(type == PokeType.Dark){
    return AppLocalizations.of(context)!.pokemon_type_dark;
  }
  else if(type == PokeType.Steel){
    return AppLocalizations.of(context)!.pokemon_type_steel;
  }
  else{
    return AppLocalizations.of(context)!.pokemon_type_fairy;
  }
}

Color showRarityColorPokemon(Rarity rarity){
  if(rarity == Rarity.casual){
    return colors.casualColor;
  }
  else if(rarity == Rarity.rare){
    return colors.rareColor;
  }
  else if(rarity == Rarity.epic){
    return colors.epicColor;
  }
  else if(rarity == Rarity.mystic){
    return colors.mysticColor;
  }
  else{
    return colors.legendaryColor;
  }
}

//todo : checkbox items to select type of pokemon in pokedex
class CheckBoxItem {

  PokeType type;
  bool itemSelected;

  CheckBoxItem({required this.type, required this.itemSelected});
}

// todo : items of store
List<ShopItem> shopItems = [
  ShopItem(imagePath: "assets/pokeimages/pb1.png", itemName: "Pokeball", itemPrice: "200"),
  ShopItem(imagePath: "assets/pokeimages/pb2.png", itemName: "Great Ball", itemPrice: "1500"),
  ShopItem(imagePath: "assets/pokeimages/pb3.png", itemName: "Ultra Ball", itemPrice: "10000"),
  ShopItem(imagePath: "assets/pokeimages/pb4.png", itemName: "Master Ball", itemPrice: "1000000"),
];

class ShopItem{
  final String imagePath;
  final String itemName;
  final String itemPrice;

  ShopItem({
    required this.imagePath,
    required this.itemName,
    required this.itemPrice
  });
}

//todo : badges in challenges
class AwardsBadges{
  final String imagePath;
  final String itemName;
  final String cityName;

  AwardsBadges({
    required this.imagePath,
    required this.itemName,
    required this.cityName
  });
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
