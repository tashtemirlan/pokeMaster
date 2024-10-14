import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContestTab extends StatefulWidget {
  @override
  _ContestTabState createState() => _ContestTabState();
}

class _ContestTabState extends State<ContestTab> {

  void showAllContestAwards(){

  }

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
              SizedBox(
                width: width,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      showAllContestAwards();
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
                        child: Icon(FontAwesomeIcons.award, color: Colors.white, size: 32,),
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