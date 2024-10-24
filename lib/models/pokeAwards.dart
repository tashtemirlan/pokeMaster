import 'package:hive/hive.dart';
part 'pokeAwards.g.dart';

@HiveType(typeId: 6)
class PokeAwards{
  @HiveField(0)
  final String awardImagePath;

  @HiveField(1)
  final bool obtained;

  @HiveField(2)
  final String awardName;

  @HiveField(3)
  final String cityName;

  const PokeAwards({
    required this.awardImagePath,
    required this.obtained,
    required this.awardName,
    required this.cityName
  });
}