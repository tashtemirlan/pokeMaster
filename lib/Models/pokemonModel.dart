import 'package:hive/hive.dart';

import '../globals.dart';


@HiveType(typeId: 0)
class Pokemon extends HiveObject{

  @HiveField(0)
  int pokeDexIndex;

  @HiveField(1)
  String name;

  @HiveField(2)
  Rarity rarity;

  @HiveField(3)
  String image;

  @HiveField(4)
  List<Type> type;

  @HiveField(5)
  int hp;

  @HiveField(6)
  int attack;

  @HiveField(7)
  int defence;

  @HiveField(8)
  int specialAttack;

  @HiveField(9)
  int specialDefence;

  @HiveField(10)
  int speed;

  @HiveField(11)
  List<Region> region;

  @HiveField(12)
  List<Type> weakness;

  Pokemon({
    required this.pokeDexIndex,
    required this.name,
    required this.rarity,
    required this.image,
    required this.type,
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed,
    required this.region,
    required this.weakness
  });

}