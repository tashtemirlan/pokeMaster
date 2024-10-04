import 'package:flutter/material.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;


class UserInventoryPage extends StatefulWidget{
  const UserInventoryPage({super.key});

  @override
  UserInventoryPageState createState ()=> UserInventoryPageState();

}

class UserInventoryPageState extends State<UserInventoryPage>{
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
                      children: [

                      ],
                    ),
                  )
              ),
            )
        )
    );
  }

}