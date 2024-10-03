library pokemon.globals;

enum Region{
  Kanto,
  Johto,
  Hoenn,
  Sinnoh,
  Unova,
  Kalos,
  Alola,
  Galar,
  Hisui,
  Paidea
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

