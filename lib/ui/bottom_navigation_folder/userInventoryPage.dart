import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../../models/pokemonUser.dart';


class UserInventoryPage extends StatefulWidget{
  const UserInventoryPage({super.key});

  @override
  UserInventoryPageState createState ()=> UserInventoryPageState();

}

class UserInventoryPageState extends State<UserInventoryPage> with SingleTickerProviderStateMixin{
  List<PokemonUser> userTeam = []; // user team for 6 Pokémon
  List<PokemonUser> userPokemons = [];
  List<int> userPokeBalls = [];

  bool dataGet = false;
  TabController? _tabController;

  Future<void> getUserData() async{
    await getUserPokemons();
    await getUserInventory();
    await getUserPokemons();
    setState(() {
      dataGet = true;
    });
  }

  Future<void> getUserInventory() async{
    var box = await Hive.openBox("PokemonUserInventory");
    List<dynamic> pokeListFromHiveDynamic = box.get("PokeballsUserInventory", defaultValue: []);
    List<int> pokeListFromHive = pokeListFromHiveDynamic.cast<int>();
    setState(() {
      userPokeBalls = pokeListFromHive;
    });
  }

  Future<void> getUserPokemons() async{
    var box = await Hive.openBox("PokemonUserInventory");
    List<dynamic> pokeListFromHiveDynamic = box.get("PokeUserInventory", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();
    setState(() {
      userPokemons = pokeListFromHive;
    });
  }

  Future<void> getUserTeamPokemons() async{
    var box = await Hive.openBox("PokemonUserTeam");
    List<dynamic> pokeListFromHiveDynamic = box.get("UserTeam", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();
    setState(() {
      userTeam = pokeListFromHive;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getUserData();
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