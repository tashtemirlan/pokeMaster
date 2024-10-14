import 'package:flutter/material.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../challenge_parts_folder/challengePartPage.dart';
import '../challenge_parts_folder/contestPartPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class ChallengePage extends StatefulWidget{
  const ChallengePage({super.key});

  @override
  ChallengePageState createState ()=> ChallengePageState();

}

class ChallengePageState extends State<ChallengePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          appBar : PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                child: AppBar(
                  backgroundColor: colors.searchBoxColor,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey.shade700,
                    indicatorColor: Colors.transparent,
                    labelStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(text: AppLocalizations.of(context)!.challenge_string),
                      Tab(text: AppLocalizations.of(context)!.contest_string),
                    ],
                  ),
                ),
              )
          ),
          body: Container(
            width: width,
            height: mainSizedBoxHeightUserNotLogged,
            color: colors.scaffoldColor,
            child: TabBarView(
              controller: _tabController,
              children: [
                ChallengeTab(),
                ContestTab(),
              ],
            ),
          ),
        )
    );
  }

}