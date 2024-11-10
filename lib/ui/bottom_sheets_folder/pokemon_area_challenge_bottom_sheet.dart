import 'package:flutter/material.dart';
import 'package:pokemonmap/models/pokemonWildModel.dart';

class BattleChallengeBottomSheetScreen extends StatefulWidget{
  final List<PokemonWild> pokeWildList;
  final int idChallenge;
  const BattleChallengeBottomSheetScreen({super.key, required this.pokeWildList, required this.idChallenge});

  @override
  BattleChallengeBottomSheetScreenState createState() => BattleChallengeBottomSheetScreenState();
}

class BattleChallengeBottomSheetScreenState extends State<BattleChallengeBottomSheetScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text("pokemon_battle_area")
            ],
          ),
        )
    );
  }
}