import 'package:flutter/material.dart';
import 'package:pokemonmap/models/pokemonWildModel.dart';

class BattleContestBottomSheetScreen extends StatefulWidget{
  const BattleContestBottomSheetScreen({super.key});

  @override
  BattleContestBottomSheetScreenState createState() => BattleContestBottomSheetScreenState();
}

class BattleContestBottomSheetScreenState extends State<BattleContestBottomSheetScreen> {

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
              Text("Battle contest bottom sheet")
            ],
          ),
        )
    );
  }
}