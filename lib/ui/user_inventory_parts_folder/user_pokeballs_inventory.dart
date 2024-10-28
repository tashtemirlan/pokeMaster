import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bottom_sheets_folder/poke_badges_bottom_sheet.dart';

class UserPokeballsTab extends StatefulWidget {
  @override
  _UserPokeballsTabState createState() => _UserPokeballsTabState();
}

class _UserPokeballsTabState extends State<UserPokeballsTab> {


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              Text("Pokeballs")
            ],
          ),
        )
    );
  }

}