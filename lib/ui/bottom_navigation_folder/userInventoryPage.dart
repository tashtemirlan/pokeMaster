  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:hive/hive.dart';
  import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

  import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
  import 'package:pokemonmap/ui/global_folder/globals.dart';

  import '../../models/pokemonUser.dart';
  import '../bottom_sheets_folder/pokemon_user_pokedex_bottom_sheet.dart';
  import '../skeleton_folder/skeleton.dart';
  import '../user_inventory_parts_folder/user_pokeballs_inventory.dart';
  import '../user_inventory_parts_folder/user_pokemons_inventory.dart';
  import 'package:flutter_gen/gen_l10n/app_localizations.dart';


  class UserInventoryPage extends StatefulWidget{
    const UserInventoryPage({super.key});

    @override
    UserInventoryPageState createState ()=> UserInventoryPageState();

  }

  class UserInventoryPageState extends State<UserInventoryPage> with SingleTickerProviderStateMixin{
    List<PokemonUser?> userTeam = List.filled(6, null, growable: false); // Slots for 6 Pokémon
    List<PokemonUser> userPokemons = [];
    List<int> userPokeBalls = [];

    bool dataGet = false;

    ScrollController scrollController = ScrollController();

    Future<void> getUserData() async{
      await getUserPokemons();
      await getUserInventory();
      await getUserTeamPokemons();
      setState(() {
        dataGet = true;
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

    Future<void> getUserInventory() async{
      var box = await Hive.openBox("PokemonUserInventory");
      List<dynamic> pokeListFromHiveDynamic = box.get("PokeballsUserInventory", defaultValue: []);
      List<int> pokeListFromHive = pokeListFromHiveDynamic.cast<int>();
      setState(() {
        userPokeBalls = pokeListFromHive;
      });
    }

    Future<void> getUserTeamPokemons() async{
      var box = await Hive.openBox("PokemonUserTeam");
      List<dynamic> pokeListFromHiveDynamic = box.get("UserTeam", defaultValue: []);
      List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();

      setState(() {
        userTeam = List.filled(6, null);
        for (int i = 0; i < pokeListFromHive.length && i < userTeam.length; i++) {
          userTeam[i] = pokeListFromHive[i];
        }
      });
    }

    // Build Pokémon team slots grid
    Widget buildPokemonSlots() {
      return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userTeam.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final pokemon = userTeam[index];
          return GestureDetector(
            onTap: (){
              if(pokemon!=null){
                viewPokeBottomSheet(pokemon);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: pokemon != null ? Colors.white : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: pokemon != null ? Colors.green : Colors.grey,
                  width: 2,
                ),
              ),
              child: pokemon != null ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(pokemon.pokemon.gifFront, height: 50, width: 50),
                  const SizedBox(height: 5),
                  Text(
                    showPokemonNameCyrillic(pokemon.pokemon.name),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${AppLocalizations.of(context)!.lvl_short_string} ${pokemon.lvl}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              )
                  : Center(child: Icon(Icons.add, color: Colors.grey, size: 40)),
            ),
          );
        },
      );
    }

    void refreshTeamData() async {
      await getUserTeamPokemons();
    }

    void refreshAllData() async {
      setState(() {
        dataGet = false;
      });
      await getUserData();
      setState(() {
        dataGet = true;
      });
    }

    void viewPokeBottomSheet(PokemonUser poke) async{
      String? pokemonUserResult = await showCupertinoModalBottomSheet<String>(
        topRadius: const Radius.circular(40),
        backgroundColor: colors.scaffoldColor,
        context: context,
        expand: true,
        builder: (BuildContext context) {
          return PokemonUserPokedexBottomSheet(pokemonUser: poke, isPokemonInUserTeam: true,);
        },
      );

      print("Pokemon result is : $pokemonUserResult");

      if(pokemonUserResult!=null){
        //Add to team or remove from it
        if(pokemonUserResult=="AddTeam" || pokemonUserResult=="DeleteTeam"){
          print("refresh user team");
          refreshTeamData();
        }
        //Release pokemon or evolve it
        else{
          print("Refreshing all");
          refreshAllData();
        }
      }
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getUserData();
    }

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double statusBarHeight = MediaQuery.of(context).padding.top;
      return PopScope(
        canPop: false,
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Container(
                width: width,
                height: height,
                color: colors.scaffoldColor,
                child: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: statusBarHeight + 10,),
                              SizedBox(
                                width: width,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.your_team_string,
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              buildPokemonSlots(),
                              const SizedBox(height: 5,),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    width: width,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      color: colors.colorSteel
                                    ),
                                  ),
                              )
                            ],
                          )
                      ),
                      SliverPersistentHeader(
                        pinned: false,
                        floating: false,
                        delegate: _SliverAppBarDelegate(
                            TabBar(
                              isScrollable: true,
                              indicatorColor: colors.searchBoxColor,
                              labelColor: colors.searchBoxColor,
                              unselectedLabelColor: colors.casualColor,
                              labelStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.01,
                              ),
                              dividerHeight: 0,
                              indicatorWeight: 1,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: colors.searchBoxColor,
                                  ),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                              tabAlignment: TabAlignment.center,
                              tabs: (dataGet)? [
                                Tab(text: AppLocalizations.of(context)!.pokemons_string),
                                Tab(text: AppLocalizations.of(context)!.items_string),
                              ] : [
                                Tab(
                                  text: "",
                                  icon: Skeleton(
                                    width: 40,
                                    height: 18,
                                    style: SkeletonStyle.text,
                                  ),
                                ),
                                Tab(
                                  text: "",
                                  icon: Skeleton(
                                    width: 40,
                                    height: 18,
                                    style: SkeletonStyle.text,
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: TabBarView(
                        children: (dataGet)? [
                          UserPokemonsTab(
                            pokemonsUser: userPokemons, pokemonsUserTeam: userTeam,
                            onTeamUpdate: refreshTeamData, onAllUpdate: refreshAllData,),
                          UserPokeballsTab(pokeballsList: userPokeBalls,),
                        ]
                            :
                        List.generate(2, (index)=> CupertinoActivityIndicator(color: colors.colorWater, radius: 15,))
                        ,
                      ),
                  ),
                )
            ),
          ),
        ),
      );
    }

  }

  class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
    final TabBar _tabBar;

    _SliverAppBarDelegate(this._tabBar);

    @override
    double get minExtent => _tabBar.preferredSize.height;
    @override
    double get maxExtent => _tabBar.preferredSize.height;

    @override
    Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Container(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _tabBar,
          ),
        ),
      );
    }

    @override
    bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
      return true;
    }
  }