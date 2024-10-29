import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonFolder/pokeType.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;

import '../../models/pokedexModel.dart';
import '../bottom_sheets_folder/pokemon_bottom_sheets.dart';
import '../bottom_sheets_folder/pokemon_pokedex_bottom_sheet.dart';
import '../global_folder/globals.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class PokedexPage extends StatefulWidget{
  const PokedexPage({super.key});

  @override
  PokedexPageState createState ()=> PokedexPageState();

}

class PokedexPageState extends State<PokedexPage>{

  List<PokedexPokemonModel> filteredPokemons = [];

  List<PokedexPokemonModel> hiveList = [];

  TextEditingController searchPokemon = TextEditingController();

  List<CheckBoxItem> listCheckBox = [];

  bool userChoseSelectionType = false;

  void viewPokeBottomSheet(int pokeIndex, bool find) async{
    showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonPokedexBottomSheet(pokeIndex: pokeIndex, showFind: find, );
      },
    );
  }

  void viewPokeTypeMultiChoiceBottomSheet() async{
    userChoseSelectionType = true;
    var result = await showCupertinoModalBottomSheet<List<globals.CheckBoxItem>>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return BottomSheetSelectMultipleOptionCheckIconRadioButton(
          listCheckBoxItems: listCheckBox,
          titleString: AppLocalizations.of(context)!.choice_type_string,
          buttonData: AppLocalizations.of(context)!.choice_string,
        );
      },
    );
    if(result!=null){
      listCheckBox = result;
      _filterSearchPokemonPokedex();
    }
  }

  Widget pokeDexPokemon(String pokemonName,  List<PokeType> types, String imagePath, int pokeInt, bool isFound) {
    // Background color based on primary type
    Color backgroundColor = typeColors[types[0]] ?? Colors.grey;

    return GestureDetector(
      onTap: (){
          viewPokeBottomSheet(pokeInt, isFound);
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pokémon GIF
            (isFound)?
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ) : Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
              color: Colors.transparent.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            // Pokémon Name
            Text(
              showPokemonNameCyrillic(pokemonName),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pokeDexList(double width) {
    return SliverGrid.builder(
      itemCount: filteredPokemons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return pokeDexPokemon(
            filteredPokemons[index].pokemon.name,
            filteredPokemons[index].pokemon.type,
            filteredPokemons[index].pokemon.gifFront,
            filteredPokemons[index].pokemon.pokeDexIndex,
            filteredPokemons[index].isFound
        );
      },
    );
  }

  Widget searchBoxPokemon(){
    return Row(
      children: [
        Expanded(child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: searchPokemon,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            autofocus: false,
            onFieldSubmitted: (value) async{
              _filterSearchPokemonPokedex();
            },
            decoration:  InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(234, 234, 234, 1)),
                  borderRadius: BorderRadius.circular(999)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(234, 234, 234, 1)),
                  borderRadius: BorderRadius.circular(999)
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(234, 234, 234, 1)),
                  borderRadius: BorderRadius.circular(999)
              ),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(234, 234, 234, 1)),
                  borderRadius: BorderRadius.circular(999)
              ),
              contentPadding: const EdgeInsets.only(left: 10, right: 20),
              hintStyle: const TextStyle(fontSize: 16 , color: Color.fromRGBO(121, 121, 121, 1) , fontWeight: FontWeight.w400),
              hintText: "",
              fillColor: colors.searchBoxColor,
              filled: true,
              prefixIcon: SizedBox(
                width: 20,
                child: Align(
                  alignment: Alignment.center,
                  child: FaIcon(FontAwesomeIcons.magnifyingGlass , color: Colors.white.withOpacity(0.8), size: 16,),
                ),
              ),
              errorStyle:TextStyle(
                  fontSize: 0
              ),
              errorMaxLines: 1,
            ),
            style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w500 , color: Colors.white.withOpacity(0.9)),
            onChanged: (value) {
              _filterSearchPokemonPokedex();
            },
          ),
        ),),
        GestureDetector(
          onTap: (){
            viewPokeTypeMultiChoiceBottomSheet();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: FaIcon(FontAwesomeIcons.gears, size: 24, color: colors.searchBoxColor,),
          ),
        )
      ],
    );
  }

  void _filterSearchPokemonPokedex(){
    //firstly we always check donut text =>
    if(searchPokemon.text.isEmpty){
      //If user not writed anything
      List<PokeType> listSelectedTypes = [];
      for(int a=0; a < listCheckBox.length; a++){
        if(listCheckBox[a].itemSelected == true){
          listSelectedTypes.add(listCheckBox[a].type);
        }
      }
      setState(() {
        if(listSelectedTypes.isEmpty){
          setDataFromHivePokedex();
        }
        else{
          filteredPokemons = [];
          for(int b=0; b < hiveList.length; b++){
            for(int c=0; c < hiveList[b].pokemon.type.length; c++){
              if(listSelectedTypes.contains(hiveList[b].pokemon.type[c])){
                filteredPokemons.add(hiveList[b]);
                break;
              }
            }
          }
        }
      });
    }
    else{
      //if user have any writted data :
      List<PokeType> listSelectedTypes = [];
      for(int a=0; a < listCheckBox.length; a++){
        if(listCheckBox[a].itemSelected == true){
          listSelectedTypes.add(listCheckBox[a].type);
        }
      }
      setState(() {
        if(listSelectedTypes.isEmpty){
          //If user not choose any type :
          filteredPokemons = [];
          for (int i = 0; i < hiveList.length; i++) {
            if (
            showPokemonNameCyrillic(hiveList[i].pokemon.name).toLowerCase().contains(searchPokemon.text.toLowerCase())
            ||
                hiveList[i].pokemon.name.toLowerCase().contains(searchPokemon.text.toLowerCase())
            ) {
              filteredPokemons.add(hiveList[i]);
            }
          }
        }
        else{
          //if user have write something on donut and have type
          filteredPokemons = [];
          for(int b=0; b < hiveList.length; b++){
            for(int c=0; c < hiveList[b].pokemon.type.length; c++){
              if(listSelectedTypes.contains(hiveList[b].pokemon.type[c])){
                if(
                showPokemonNameCyrillic(hiveList[b].pokemon.name).toLowerCase().contains(searchPokemon.text.toLowerCase())
                ||
                hiveList[b].pokemon.name.toLowerCase().contains(searchPokemon.text.toLowerCase())
                ) {
                  filteredPokemons.add(hiveList[b]);
                }
                break;
              }
            }
          }
        }
      });
    }
  }

  void fillCheckList(){
    for(int i=0; i<globals.listTypes.length; i++){
      CheckBoxItem checkBoxItem = globals.CheckBoxItem(type: globals.listTypes[i], itemSelected: false);
      listCheckBox.add(checkBoxItem);
    }
  }

  Future<void> setDataFromHivePokedex() async{
    filteredPokemons = hiveList;
  }

  Future<void> setDataFromHivePokedexInitialized() async{
    var box = await Hive.openBox("PokemonUserPokedex");

    // Read the list from Hive and cast it to List<PokedexPokemonModel>
    List<dynamic> pokeListFromHiveDynamic = box.get("Pokedex", defaultValue: []);

    // Cast the list to List<PokedexPokemonModel>
    List<PokedexPokemonModel> pokeListFromHive = pokeListFromHiveDynamic.cast<PokedexPokemonModel>();

    setState(() {
      hiveList = pokeListFromHive;
      filteredPokemons = pokeListFromHive;
    });
  }

  @override
  void initState() {
    super.initState();
    setDataFromHivePokedexInitialized();
    fillCheckList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double mainSizedBoxHeightUserNotLogged = height  - statusBarHeight;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: Container(
            width: width,
            height: mainSizedBoxHeightUserNotLogged,
            color: colors.scaffoldColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: searchBoxPokemon(),
                  ),
                  pokeDexList(width),
                  SliverToBoxAdapter(
                    child: const SizedBox(height: 20,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}