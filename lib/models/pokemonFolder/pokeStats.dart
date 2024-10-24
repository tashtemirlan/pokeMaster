import 'package:hive/hive.dart';
part 'pokeStats.g.dart';


@HiveType(typeId: 2)
class PokeStats {
  @HiveField(0)
  double hp;

  @HiveField(1)
  double attack;

  @HiveField(2)
  double defence;

  @HiveField(3)
  double specialAttack;

  @HiveField(4)
  double specialDefence;

  @HiveField(5)
  double speed;

  PokeStats({
    required this.hp,
    required this.attack,
    required this.defence,
    required this.specialAttack,
    required this.specialDefence,
    required this.speed,
  });
}