library pokemon.globals;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pokemonmap/models/pokemonModel.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

int userCoins = 0;

List<Pokemon> listAllPokemons = [];

List<Type> listTypes = [
  Type.Normal,
  Type.Fire,
  Type.Water,
  Type.Electric,
  Type.Grass,
  Type.Ice,
  Type.Fighting,
  Type.Poison,
  Type.Ground,
  Type.Flying,
  Type.Psychic,
  Type.Bug,
  Type.Rock,
  Type.Ghost,
  Type.Dragon,
  Type.Dark,
  Type.Steel,
  Type.Fairy
];

List<Rarity> listRarity = [
  Rarity.casual,
  Rarity.rare,
  Rarity.epic,
  Rarity.mystic,
  Rarity.legendary
];

enum Region{
  Kanto,
  Johto,
  Hoenn,
  Sinnoh,
  Unova,
  Kalos,
}

enum Rarity{
  casual,
  rare,
  epic,
  mystic,
  legendary
}

enum Type{
  Normal,
  Fire,
  Water,
  Electric,
  Grass,
  Ice,
  Fighting,
  Poison,
  Ground,
  Flying,
  Psychic,
  Bug,
  Rock,
  Ghost,
  Dragon,
  Dark,
  Steel,
  Fairy
}

class PokeStats{
  double hp;
  double attack;
  double defence;
  double specialAttack;
  double specialDefence;
  double speed;

  PokeStats({
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed
  });
}

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

String showTypePokemon(Type type, BuildContext context){
  if(type == Type.Normal){
    return AppLocalizations.of(context)!.pokemon_type_normal;
  }
  else if(type == Type.Fire){
    return AppLocalizations.of(context)!.pokemon_type_fire;
  }
  else if(type == Type.Water){
    return AppLocalizations.of(context)!.pokemon_type_water;
  }
  else if(type == Type.Electric){
    return AppLocalizations.of(context)!.pokemon_type_electric;
  }
  else if(type == Type.Grass){
    return AppLocalizations.of(context)!.pokemon_type_grass;
  }
  else if(type == Type.Ice){
    return AppLocalizations.of(context)!.pokemon_type_ice;
  }
  else if(type == Type.Fighting){
    return AppLocalizations.of(context)!.pokemon_type_fighting;
  }
  else if(type == Type.Poison){
    return AppLocalizations.of(context)!.pokemon_type_poison;
  }
  else if(type == Type.Ground){
    return AppLocalizations.of(context)!.pokemon_type_ground;
  }
  else if(type == Type.Flying){
    return AppLocalizations.of(context)!.pokemon_type_flying;
  }
  else if(type == Type.Psychic){
    return AppLocalizations.of(context)!.pokemon_type_psychic;
  }
  else if(type == Type.Bug){
    return AppLocalizations.of(context)!.pokemon_type_bug;
  }
  else if(type == Type.Ghost){
    return AppLocalizations.of(context)!.pokemon_type_ghost;
  }
  else if(type == Type.Dragon){
    return AppLocalizations.of(context)!.pokemon_type_dragon;
  }
  else if(type == Type.Dark){
    return AppLocalizations.of(context)!.pokemon_type_dark;
  }
  else if(type == Type.Steel){
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

  Type type;
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

List<AwardsBadges> kantoGym = [];
List<AwardsBadges> johtoGym = [];
List<AwardsBadges> hoennGym = [];
List<AwardsBadges> sinnohGym = [];
List<AwardsBadges> unovaGym = [];
List<AwardsBadges> kalosGym = [];

//todo : badges in contests
List<AwardsBadges> kantoContest = [];

List<AwardsBadges> johtoContest = [];
List<AwardsBadges> hoennContest = [];
List<AwardsBadges> sinnohContest = [];
List<AwardsBadges> unovaContest = [];
List<AwardsBadges> kalosContest = [];

