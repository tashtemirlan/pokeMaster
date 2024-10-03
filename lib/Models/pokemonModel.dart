import 'package:hive/hive.dart';

import '../UI/GlobalFolder/globals.dart';


@HiveType(typeId: 0)
class Pokemon extends HiveObject{

  @HiveField(0)
  int pokeDexIndex;

  @HiveField(1)
  String name;

  @HiveField(2)
  Rarity rarity;

  @HiveField(3)
  List<Type> type;

  @HiveField(4)
  int hp;

  @HiveField(5)
  int attack;

  @HiveField(6)
  int defence;

  @HiveField(7)
  int specialAttack;

  @HiveField(8)
  int specialDefence;

  @HiveField(9)
  int speed;

  @HiveField(10)
  Region region;

  @HiveField(11)
  List<Type?> weakness;

  @HiveField(12)
  String gifFront;

  @HiveField(13)
  String gifBack;

  Pokemon({
    required this.pokeDexIndex,
    required this.name,
    required this.rarity,
    required this.type,
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed,
    required this.region,
    required this.weakness,
    required this.gifFront,
    required this.gifBack
  });

}