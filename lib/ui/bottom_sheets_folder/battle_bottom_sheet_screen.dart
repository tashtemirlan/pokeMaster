import 'package:flutter/material.dart';
import 'package:pokemonmap/models/pokemonWildModel.dart';


class BattleBottomSheetScreen extends StatefulWidget{
  final List<PokemonWild> pokeWildList;
  const BattleBottomSheetScreen({super.key, required this.pokeWildList});

  @override
  BattleBottomSheetScreenState createState() => BattleBottomSheetScreenState();
}

class BattleBottomSheetScreenState extends State<BattleBottomSheetScreen> {

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
              Text("battle_wild_pokemon_bottom_sheet")
            ],
          ),
        )
    );
  }
}