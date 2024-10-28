import 'dart:developer';
import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:pokemonmap/models/pokemonUser.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;

import '../../models/pokedexModel.dart';
import '../../models/pokemonFolder/pokeStats.dart';
import '../global_folder/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokemonUserPokedexBottomSheet extends StatefulWidget{
  final PokemonUser pokemonUser;
  const PokemonUserPokedexBottomSheet({super.key, required this.pokemonUser});

  @override
  PokemonUserPokedexBottomSheetState createState() => PokemonUserPokedexBottomSheetState();
}

class PokemonUserPokedexBottomSheetState extends State<PokemonUserPokedexBottomSheet> {

  bool dataGet = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: (dataGet)?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text("Pokemon of user data")
              ],
            ) :
            Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade400,
                strokeWidth: 7,
              ),
            )
        )
    );
  }
}