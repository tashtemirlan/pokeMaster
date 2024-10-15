import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/ui/bottom_sheets_folder/poke_badges_bottom_sheet.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChallengeTab extends StatefulWidget {
  @override
  _ChallengeTabState createState() => _ChallengeTabState();
}

class _ChallengeTabState extends State<ChallengeTab> {

  void showAllGymBadges(){
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return PokeBadgesBottomSheet(
          showGym: true,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                SizedBox(height: 15,),
                SizedBox(
                  width: width,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: (){
                        showAllGymBadges();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colors.searchBoxColor
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.briefcase, color: Colors.white, size: 32,),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
    );
  }

}