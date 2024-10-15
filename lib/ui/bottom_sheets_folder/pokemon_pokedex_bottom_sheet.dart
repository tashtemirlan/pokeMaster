import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;

import '../global_folder/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PokemonPokedexBottomSheet extends StatefulWidget{
  final int pokeIndex;
  const PokemonPokedexBottomSheet({super.key, required this.pokeIndex});

  @override
  PokemonPokedexBottomSheetState createState() => PokemonPokedexBottomSheetState();
}

class PokemonPokedexBottomSheetState extends State<PokemonPokedexBottomSheet> {

  bool frontView = false;
  String gifPath = "";

  void changeImageView(){
    if(frontView==true){
      // show back view
      setState(() {
        gifPath = globals.pokeList[widget.pokeIndex].gifBack;
        frontView = false;
      });
    }
    else{
      //show front view
      setState(() {
        gifPath = globals.pokeList[widget.pokeIndex].gifFront;
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
    PokeStats pokemon_Stats = globals.pokeList[widget.pokeIndex].pokeStats;
    double pokemon_hp = pokemon_Stats.hp;
    double pokemon_attack = pokemon_Stats.attack;
    double pokemon_defence = pokemon_Stats.defence;
    double pokemon_sp_attack = pokemon_Stats.specialAttack;
    double pokemon_sp_defence = pokemon_Stats.specialDefence;
    double pokemon_speed = pokemon_Stats.speed;
    List<double> pokeData = [pokemon_hp, pokemon_attack ,pokemon_defence, pokemon_sp_attack , pokemon_sp_defence, pokemon_speed];
    Color? colorPokeCharts = typeColors[globals.pokeList[widget.pokeIndex].type.first];
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
                "${globals.pokeList[widget.pokeIndex].pokeStats.hp}",
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
                "${globals.pokeList[widget.pokeIndex].pokeStats.attack}",
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
                "${globals.pokeList[widget.pokeIndex].pokeStats.defence}",
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
                "${globals.pokeList[widget.pokeIndex].pokeStats.specialAttack}",
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
                "${globals.pokeList[widget.pokeIndex].pokeStats.specialDefence}",
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
                "${globals.pokeList[widget.pokeIndex].pokeStats.speed}",
                style: TextStyle(color: Colors.black , fontSize: 18,
                    decoration: TextDecoration.none, fontWeight: FontWeight.bold ,fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    changeImageView();
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
                  globals.pokeList[widget.pokeIndex].name,
                  style: TextStyle(color: Colors.black, fontSize: 24, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5,
                children: globals.pokeList[widget.pokeIndex].type.map((type) {
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
                              "${AppLocalizations.of(context)!.rarity_string} : ",
                              style: TextStyle(color: Colors.black , fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                showRarityPokemon(globals.pokeList[widget.pokeIndex].rarity, context),
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
                                showRegionPokemon(globals.pokeList[widget.pokeIndex].region, context),
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
                          children: globals.pokeList[widget.pokeIndex].weakness.map((type) {
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
                        const SizedBox(height: 30,)
                      ],
                    ),
                ),
              )
            ],
          ),
        )
    );
  }
}