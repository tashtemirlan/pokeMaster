library pokemon.globals;

import 'dart:ui';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;


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
  int hp;
  int attack;
  int defence;
  int specialAttack;
  int specialDefence;
  int speed;

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