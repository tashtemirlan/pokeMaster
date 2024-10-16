import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pokemonmap/models/pokemonModel.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;

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

  late List<Pokemon> filteredPokemons;

  TextEditingController searchPokemon = TextEditingController();

  List<CheckBoxItem> listCheckBox = [];

  bool userChoseSelectionType = false;

  void viewPokeBottomSheet(int pokeIndex) async{
    showCupertinoModalBottomSheet<String>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: true,
      builder: (BuildContext context) {
        return PokemonPokedexBottomSheet(pokeIndex: pokeIndex);
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
      _filterByType();
    }
  }

  Widget pokeDexPokemon(String pokemonName,  List<Type> types, String imagePath, int pokeInt) {
    // Background color based on primary type
    Color backgroundColor = typeColors[types[0]] ?? Colors.grey;

    return GestureDetector(
      onTap: (){
          viewPokeBottomSheet(pokeInt);
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
            Image.asset(
              imagePath,
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            // Pokémon Name
            Text(
              pokemonName,
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
            filteredPokemons[index].name,
            filteredPokemons[index].type,
            filteredPokemons[index].gifFront,
            filteredPokemons[index].pokeDexIndex);
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
              _filterList(value);
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
              _filterList(value);
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

  void _filterList(String query) {
    listCheckBox = [];
    fillCheckList();
    setState(() {
      if (query.isEmpty) {
        filteredPokemons = globals.pokeList;
      } else {
        filteredPokemons = [];
        for (int i = 0; i < globals.pokeList.length; i++) {
          if (globals.pokeList[i].name.toLowerCase().contains(query.toLowerCase())) {
            filteredPokemons.add(globals.pokeList[i]);
          }
        }
      }
    });
  }

  void _filterByType(){
    List<globals.Type> listSelectedTypes = [];
    for(int a=0; a < listCheckBox.length; a++){
      if(listCheckBox[a].itemSelected == true){
        listSelectedTypes.add(listCheckBox[a].type);
      }
    }
    setState(() {
      if(listSelectedTypes.isEmpty){
        filteredPokemons = globals.pokeList;
      }
      else{
        filteredPokemons = [];
        for(int b=0; b < globals.pokeList.length; b++){
          for(int c=0; c<globals.pokeList[b].type.length; c++){
            if(listSelectedTypes.contains(globals.pokeList[b].type[c])){
              filteredPokemons.add(globals.pokeList[b]);
              break;
            }
          }
        }
      }
    });
  }

  void fillCheckList(){
    for(int i=0; i<globals.listTypes.length; i++){
      CheckBoxItem checkBoxItem = globals.CheckBoxItem(type: globals.listTypes[i], itemSelected: false);
      listCheckBox.add(checkBoxItem);
    }
  }

  @override
  void initState() {
    super.initState();
    filteredPokemons = globals.pokeList;
    fillCheckList();
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