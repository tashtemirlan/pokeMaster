import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemonmap/UI/BottomNavigationFolder/challengePage.dart';
import 'package:pokemonmap/UI/BottomNavigationFolder/mapPage.dart';
import 'package:pokemonmap/UI/BottomNavigationFolder/pokedexPage.dart';
import 'package:pokemonmap/UI/BottomNavigationFolder/shopPage.dart';
import 'package:pokemonmap/UI/BottomNavigationFolder/userInventoryPage.dart';
import 'package:pokemonmap/UI/GlobalFolder/colors.dart' as colors;




class BottomPokeNavigationBar extends ConsumerStatefulWidget {
  const BottomPokeNavigationBar({super.key});

  @override
  BottomPokeNavigationBarState createState() => BottomPokeNavigationBarState();
}

class BottomPokeNavigationBarState extends ConsumerState<BottomPokeNavigationBar> {

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
          color: colors.scaffoldColor.withOpacity(0.75),
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
                    child: Container(color: Colors.pink.shade100,)
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
                      child: Container(color: Colors.pink.shade200,)
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
                    child: Container(color: Colors.pink.shade300,)
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
                      child: Container(color: Colors.pink.shade400,)
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
                      child: Container(color: Colors.pink.shade500,)
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}