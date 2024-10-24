import 'package:hive/hive.dart';
part 'pokeRegion.g.dart';

@HiveType(typeId: 3)
enum Region {
  @HiveField(0)
  Kanto,

  @HiveField(1)
  Johto,

  @HiveField(2)
  Hoenn,

  @HiveField(3)
  Sinnoh,

  @HiveField(4)
  Unova,

  @HiveField(5)
  Kalos,
}