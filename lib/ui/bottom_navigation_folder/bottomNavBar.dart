import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:pokemonmap/ui/bottom_navigation_folder/pokedexPage.dart';
import 'package:pokemonmap/ui/bottom_navigation_folder/shopPage.dart';
import 'package:pokemonmap/ui/bottom_navigation_folder/userInventoryPage.dart';

import 'challengePage.dart';
import 'mapPage.dart';




class BottomPokeNavigationBar extends StatefulWidget {
  const BottomPokeNavigationBar({super.key});

  @override
  BottomPokeNavigationBarState createState() => BottomPokeNavigationBarState();
}

class BottomPokeNavigationBarState extends State<BottomPokeNavigationBar> {

  int selectedBottomNavBarIndex = 2;

  final PageController _pageController = PageController(initialPage: 2);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedBottomNavBarIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index){
          setState(() {
            selectedBottomNavBarIndex = index;
          });
        },
        children: const [
          ShopPage(),
          UserInventoryPage(),
          MapPage(),
          ChallengePage(),
          PokedexPage()
        ],
      ),
      bottomNavigationBar: Container(
          width: width,
          height: 80,
          padding: EdgeInsets.zero,
          color: colors.scaffoldColor.withOpacity(0.6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: Container(
                  color: Colors.transparent,
                  width: width / 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.transparent,
                      child: FaIcon(FontAwesomeIcons.shop, color: colors.darkBlack, size: 24,),
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: Container(
                  color: Colors.transparent,
                  width: width / 5,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.transparent,
                          child: FaIcon(FontAwesomeIcons.inbox, color: colors.darkBlack, size: 24,)
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: Container(
                  color: Colors.transparent,
                  width: width / 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                        color: Colors.transparent,
                        child: FaIcon(FontAwesomeIcons.solidMap, color: colors.darkBlack, size: 24,)
                    )
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(3),
                child: Container(
                  color: Colors.transparent,
                  width: width / 5,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          color: Colors.transparent,
                          child: FaIcon(FontAwesomeIcons.trophy, color: colors.darkBlack, size: 24,)
                      )
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _onItemTapped(4),
                child: Container(
                  color: Colors.transparent,
                  width: width / 5,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          color: Colors.transparent,
                          child: FaIcon(FontAwesomeIcons.layerGroup, color: colors.darkBlack, size: 24,)
                      )
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}