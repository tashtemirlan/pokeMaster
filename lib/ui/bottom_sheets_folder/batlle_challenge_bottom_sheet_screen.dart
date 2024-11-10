import 'package:flutter/material.dart';
import 'package:pokemonmap/models/pokemonWildModel.dart';

class BattleChallengeBottomSheetScreen extends StatefulWidget{
  final List<PokemonWild> pokeWildList;
  const BattleChallengeBottomSheetScreen({super.key, required this.pokeWildList});

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
              Text("battle_challenge_bottom_sheet")
            ],
          ),
        )
    );
  }
}