import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../bottom_sheets_folder/poke_rullete_bottom_sheet.dart';


class MapPage extends StatefulWidget{
  const MapPage({super.key});

  @override
  MapPageState createState ()=> MapPageState();

}

class MapPageState extends State<MapPage>{

  void viewPokeRouletteBottomSheet() async{
    showCupertinoModalBottomSheet(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return PokemonRouletteBottomSheet();
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double mainSizedBoxHeightUserNotLogged = height  - statusBarHeight - 80;
    return PopScope(
        canPop: false,
        child: Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Container(
                  width: width,
                  height: mainSizedBoxHeightUserNotLogged,
                  color: colors.scaffoldColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(onPressed: (){
                          viewPokeRouletteBottomSheet();
                        }, child: Text("Start Spin", style: TextStyle(color: Colors.blue.shade500, fontSize: 52),))
                      ],
                    ),
                  )
              ),
            )
        )
    );
  }

}