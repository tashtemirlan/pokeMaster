import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:pokemonmap/models/pokemonUser.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:pokemonmap/ui/global_folder/evolution_folder/evolution.dart';

import '../../models/pokemonFolder/pokeStats.dart';
import '../../models/pokemonFolder/pokemonModel.dart';
import '../global_folder/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokemonUserPokedexBottomSheet extends StatefulWidget{
  final PokemonUser pokemonUser;
  final bool isPokemonInUserTeam;
  const PokemonUserPokedexBottomSheet({super.key, required this.pokemonUser, required this.isPokemonInUserTeam});

  @override
  PokemonUserPokedexBottomSheetState createState() => PokemonUserPokedexBottomSheetState();
}

class PokemonUserPokedexBottomSheetState extends State<PokemonUserPokedexBottomSheet> {

  String gifPath = "";
  bool dataGet = false;
  bool frontView = false;
  bool evolutionIsPossible = false;

  void changeImageView(){
    if(frontView==true){
      // show back view
      setState(() {
        gifPath = widget.pokemonUser.pokemon.gifBack;
        frontView = false;
      });
    }
    else{
      //show front view
      setState(() {
        gifPath = widget.pokemonUser.pokemon.gifFront;
        frontView = true;
      });
    }
  }

  Widget radarChartPokemon(List<double> listPokeData, Color color, double height){
    return SizedBox(
      height: height,
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              fillColor: color.withOpacity(0.3),
              borderColor: color,
              entryRadius: 5,
              dataEntries: listPokeData.map((e) => RadarEntry(value: e / 200)).toList(),
            ),
          ],
          radarBackgroundColor: Colors.transparent,
          radarBorderData: const BorderSide(color: Colors.black),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 10, decoration: TextDecoration.none, fontWeight: FontWeight.bold
          ),
          getTitle: (index, angle) {
            switch (index) {
              case 0:
                return RadarChartTitle(text: AppLocalizations.of(context)!.pokemon_stats_hp);
              case 1:
                return RadarChartTitle(text: AppLocalizations.of(context)!.pokemon_stats_attack);
              case 2:
                return RadarChartTitle(text: AppLocalizations.of(context)!.pokemon_stats_defence);
              case 3:
                return RadarChartTitle(text: AppLocalizations.of(context)!.pokemon_stats_special_attack);
              case 4:
                return RadarChartTitle(text: AppLocalizations.of(context)!.pokemon_stats_special_defence);
              case 5:
                return RadarChartTitle(text: AppLocalizations.of(context)!.pokemon_stats_speed);
              default:
                return RadarChartTitle(text: '');
            }
          },
          gridBorderData: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
          tickBorderData: const BorderSide(color: Colors.grey),
          tickCount: 5,
          ticksTextStyle: TextStyle(fontSize: 0),
        ),
      ),
    );
  }

  Widget pokemonStats(double height){
    PokeStats pokemon_Stats = widget.pokemonUser.pokemon.pokeStats;
    double pokemon_hp = pokemon_Stats.hp;
    double pokemon_attack = pokemon_Stats.attack;
    double pokemon_defence = pokemon_Stats.defence;
    double pokemon_sp_attack = pokemon_Stats.specialAttack;
    double pokemon_sp_defence = pokemon_Stats.specialDefence;
    double pokemon_speed = pokemon_Stats.speed;
    List<double> pokeData = [pokemon_hp, pokemon_attack ,pokemon_defence, pokemon_sp_attack , pokemon_sp_defence, pokemon_speed];
    Color? colorPokeCharts = typeColors[widget.pokemonUser.pokemon.type.first];
    Color showColor = (colorPokeCharts!=null)? colorPokeCharts : Colors.blue.shade600;
    return radarChartPokemon(pokeData, showColor, height);
  }

  Widget rowDataPokemon(width){
    return Column(
      children: [
        //HP
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.pokemon_stats_hp} : ",
              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                "${widget.pokemonUser.pokemon.pokeStats.hp}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        //Attack
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.pokemon_stats_attack} : ",
              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                "${widget.pokemonUser.pokemon.pokeStats.attack}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        // Defence
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.pokemon_stats_defence} : ",
              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                "${widget.pokemonUser.pokemon.pokeStats.defence}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        // Special attack
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.pokemon_stats_special_attack} : ",
              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                "${widget.pokemonUser.pokemon.pokeStats.specialAttack}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        // Special defence
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.pokemon_stats_special_defence} : ",
              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                "${widget.pokemonUser.pokemon.pokeStats.specialDefence}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        // speed
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.pokemon_stats_speed} : ",
              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Text(
                "${widget.pokemonUser.pokemon.pokeStats.speed}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> setData() async{
    changeImageView();
    setState(() {
      evolutionIsPossible = pokemonCanEvolve(widget.pokemonUser);
      dataGet = true;
    });
  }

  Future<void> addToTeam(PokemonUser poke) async{
    var box = await Hive.openBox("PokemonUserTeam");
    List<dynamic> pokeListFromHiveDynamic = box.get("UserTeam", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();
    if(pokeListFromHive.length >5 || widget.isPokemonInUserTeam){
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: AppLocalizations.of(context)!.pokemons_team_overload_title_string,
          message: AppLocalizations.of(context)!.pokemons_team_overload_description_string,
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
    else{
      pokeListFromHive.add(poke);
      box.put("UserTeam", pokeListFromHive);
    }
  }

  Future<void> removeFromTeam(PokemonUser poke) async{
    var box = await Hive.openBox("PokemonUserTeam");
    List<dynamic> pokeListFromHiveDynamic = box.get("UserTeam", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();

    // Remove the Pokémon if it exists in the team
    pokeListFromHive.removeWhere((teamPokemon) => teamPokemon.hashId == poke.hashId);

    // Update the box
    await box.put("UserTeam", pokeListFromHive);
  }

  Future<void> releasePokemon(PokemonUser poke) async{
    var box = await Hive.openBox("PokemonUserInventory");
    List<dynamic> pokeListFromHiveDynamic = box.get("PokeUserInventory", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();

    // Remove the Pokémon from the inventory
    pokeListFromHive.removeWhere((inventoryPokemon) => inventoryPokemon.hashId == poke.hashId);

    // Update the box
    await box.put("PokeUserInventory", pokeListFromHive);

    // Also remove from the team if it exists there
    await removeFromTeam(poke);
    Navigator.pop(context);
  }

  void showReleaseAlert(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          title: Text(
              AppLocalizations.of(context)!.release_pokemon_string, textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, color: colors.darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
              )
          ),
          content: Text(
              AppLocalizations.of(context)!.evolution_alert_subtitle, textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14, color: colors.casualColor, fontWeight: FontWeight.w500 , letterSpacing: 0.1
              )
          ),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                            await releasePokemon(widget.pokemonUser);
                            Navigator.pop(context, "ReleasePokemon");
                        },
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(colors.colorFire)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              AppLocalizations.of(context)!.yes_string,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async{
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(colors.searchBoxColor)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                              AppLocalizations.of(context)!.no_string,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              )),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void showEvolveAlert(double width, PokemonUser pokemonUser) {
    List<Pokemon?> pokemonToEvolveList = pokemonOnWhichEvolve(pokemonUser);
    Pokemon? selectedPokemon;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              scrollable: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              title: Text(
                  AppLocalizations.of(context)!.evolution_alert_title, textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24, color: colors.darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                  )
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      AppLocalizations.of(context)!.evolution_alert_subtitle, textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: colors.casualColor, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                      )
                  ),
                  const SizedBox(height: 5,),
                  Text(
                      AppLocalizations.of(context)!.evolution_to_string, textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, color: colors.casualColor, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                      )
                  ),
                  const SizedBox(height: 10,),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: pokemonToEvolveList.map((pokemonEvolution) {
                      final isSelected = selectedPokemon == pokemonEvolution;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPokemon = pokemonEvolution;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: Colors.green, width: 3)
                                : Border.all(color: Colors.transparent),
                          ),
                          child: Column(
                            children: [
                              if (pokemonEvolution != null)
                                Image.asset(
                                  pokemonEvolution.gifFront,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                ),
                              const SizedBox(height: 10),
                              if (pokemonEvolution != null)
                                Text(
                                    showPokemonNameCyrillic(pokemonEvolution.name),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: colors.darkBlack, fontWeight: FontWeight.w500 , letterSpacing: 0.1
                                    )
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
              actionsPadding: EdgeInsets.zero,
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (pokemonToEvolveList.length == 1 || selectedPokemon != null)
                              ? () async{
                            await evolvePokemon(pokemonUser, selectedPokemon!);
                            Navigator.pop(context, "EvolvePokemon");
                          }
                              : null, // Disable if nothing selected and multiple options
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            backgroundColor: (selectedPokemon!=null)?WidgetStateProperty.all<Color>(
                                colors.colorFire
                            ) : WidgetStateProperty.all<Color>(
                                colors.colorFire.withOpacity(0.1)
                            )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)!.yes_string,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(
                                colors.searchBoxColor
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)!.no_string,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600 , letterSpacing: 0.01
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> evolvePokemon(PokemonUser pokemonUser, Pokemon pokemon) async{
    //get evolved pokemonUser =>
    PokemonUser evolvedPokemonUser = evolvePokemonUser(pokemonUser, pokemon);
    var box = await Hive.openBox("PokemonUserInventory");

    // Retrieve the current Pokémon inventory
    List<dynamic> pokeListFromHiveDynamic = box.get("PokeUserInventory", defaultValue: []);
    List<PokemonUser> pokeListFromHive = pokeListFromHiveDynamic.cast<PokemonUser>();

    // Find the Pokémon in the inventory by hashId
    int pokemonIndex = pokeListFromHive.indexWhere((inventoryPokemon) => inventoryPokemon.hashId == pokemonUser.hashId);
    if (pokemonIndex != -1) {
      // Replace the Pokémon with its evolved form
      pokeListFromHive[pokemonIndex] = PokemonUser(
        pokemon: evolvedPokemonUser.pokemon,
        lvl: pokemonUser.lvl,
        hashId: pokemonUser.hashId,
      );

      // Update the inventory in the box
      await box.put("PokeUserInventory", pokeListFromHive);
    }

    // If the Pokémon is in the user's team, update it there as well
    await updateTeamPokemon(pokemonUser, evolvedPokemonUser.pokemon);
    Navigator.pop(context);
  }

  // Helper method to update the evolved Pokémon in the team
  Future<void> updateTeamPokemon(PokemonUser oldPokemon, Pokemon newPokemon) async {
    var teamBox = await Hive.openBox("PokemonUserTeam");

    // Retrieve the current team
    List<dynamic> teamListFromHiveDynamic = teamBox.get("UserTeam", defaultValue: []);
    List<PokemonUser> teamListFromHive = teamListFromHiveDynamic.cast<PokemonUser>();

    // Find and update the Pokémon in the team by hashId
    int teamPokemonIndex = teamListFromHive.indexWhere((teamPokemon) => teamPokemon.hashId == oldPokemon.hashId);
    if (teamPokemonIndex != -1) {
      // Replace the Pokémon with its evolved form
      teamListFromHive[teamPokemonIndex] = PokemonUser(
        pokemon: newPokemon,
        lvl: oldPokemon.lvl,
        hashId: oldPokemon.hashId,
      );

      // Update the team in the box
      await teamBox.put("UserTeam", teamListFromHive);
    }
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: (dataGet)?
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InstaImageViewer(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            gifPath,
                            height: width *0.6,
                            width: width,
                            fit: BoxFit.contain,
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        changeImageView();
                      },
                      child: FaIcon(FontAwesomeIcons.rotate, size: 32, color: Colors.black,),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  showPokemonNameCyrillic(widget.pokemonUser.pokemon.name),
                  style: TextStyle(color: Colors.black, fontSize: 24, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  children: widget.pokemonUser.pokemon.type.map((type) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color:  typeColors[type]?.withOpacity(0.85) ?? Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: Colors.grey,
                              width: 1
                          )
                      ),
                      child: Text(
                        showTypePokemon(type, context),
                        style:  TextStyle(color: Colors.white, fontSize: 14,
                            fontWeight: FontWeight.bold, decoration: TextDecoration.none, fontStyle: FontStyle.italic),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                //Todo : poke data =>
                SizedBox(
                  width: width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.find_string} : ",
                              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.yes_string,
                                style: TextStyle(color: Colors.black , fontSize: 18,
                                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.rarity_string} : ",
                              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                showRarityPokemon(widget.pokemonUser.pokemon.rarity, context),
                                style: TextStyle(color: Colors.black , fontSize: 18,
                                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.region_string} : ",
                              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                showRegionPokemon(widget.pokemonUser.pokemon.region, context),
                                style: TextStyle(color: Colors.black , fontSize: 18,
                                    decoration: TextDecoration.none, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${AppLocalizations.of(context)!.pokemon_type_weakness_string} : ",
                          style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: widget.pokemonUser.pokemon.weakness.map((type) {
                            if(type!=null){
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color:  typeColors[type]?.withOpacity(0.85) ?? Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.grey,
                                        width: 1
                                    )
                                ),
                                child: Text(
                                  showTypePokemon(type, context),
                                  style:  TextStyle(color: Colors.white, fontSize: 14,
                                      fontWeight: FontWeight.bold, decoration: TextDecoration.none, fontStyle: FontStyle.italic),
                                ),
                              );
                            }
                            else{
                              return SizedBox();
                            }
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${AppLocalizations.of(context)!.pokemon_stats_string} : ",
                          style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        rowDataPokemon(width),
                        const SizedBox(height: 20),
                        pokemonStats(height/2),
                        const SizedBox(height: 20),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () async{
                                      //Add or remove from user team
                                      if(widget.isPokemonInUserTeam){
                                        await removeFromTeam(widget.pokemonUser);
                                        Navigator.pop(context, "DeleteTeam");
                                      }
                                      else{
                                        await addToTeam(widget.pokemonUser);
                                        Navigator.pop(context, "AddTeam");
                                      }
                                    },
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(999),
                                          ),
                                        ),
                                        backgroundColor: WidgetStateProperty.all<Color>(colors.searchBoxColor)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Text(
                                          (widget.isPokemonInUserTeam)?
                                          AppLocalizations.of(context)!.remove_from_team_string :
                                          AppLocalizations.of(context)!.add_to_team_string,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold , letterSpacing: 0.01
                                          )),
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () async{
                                      if(evolutionIsPossible){
                                        //Evolve pokemon show alert
                                        showEvolveAlert(width, widget.pokemonUser);
                                      }
                                      else{
                                        //show alert dialog that pokemon can't be evolved
                                        Navigator.pop(context);
                                        final snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: AppLocalizations.of(context)!.evolution_error,
                                            message: AppLocalizations.of(context)!.evolution_error,
                                            contentType: ContentType.failure,
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);
                                      }
                                    },
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(999),
                                          ),
                                        ),
                                        backgroundColor: (evolutionIsPossible)? WidgetStateProperty.all<Color>(Colors.orange) :
                                        WidgetStateProperty.all<Color>(colors.colorSteel.withOpacity(0.3))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Text(
                                          AppLocalizations.of(context)!.evolution_string,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold , letterSpacing: 0.01
                                          )),
                                    )
                                )
                              ],
                            ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: width,
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () async{
                                  //Release pokemon
                                  showReleaseAlert();
                                },
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(999),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all<Color>(colors.colorFire)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                      AppLocalizations.of(context)!.release_pokemon_string,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold , letterSpacing: 0.01
                                      )),
                                )
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,)
                      ],
                    ),
                  ),
                )
              ],
            ) :
            Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade400,
                strokeWidth: 5,
              ),
            )
        )
    );
  }
}