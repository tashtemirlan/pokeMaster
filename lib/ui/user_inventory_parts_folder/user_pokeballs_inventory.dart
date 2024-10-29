import 'package:flutter/material.dart';
import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import '../global_folder/globals.dart';

class UserPokeballsTab extends StatefulWidget {
  final List<int> pokeballsList;
  const UserPokeballsTab({super.key, required this.pokeballsList});

  @override
  _UserPokeballsTabState createState() => _UserPokeballsTabState();
}

class _UserPokeballsTabState extends State<UserPokeballsTab> {

  Widget inventoryItem(double width, ShopItem shopItem, int index) {
    return Container(
      width: width/3,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            shopItem.imagePath,
            height: 80,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8.0),
          // Item name
          Text(
            showPokemonNameCyrillic(shopItem.itemName),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.darkBlack),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          // Item price
          Text(
            widget.pokeballsList[index].toString(),
            style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget inventoryItems(double width){
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: shopItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return inventoryItem(width, item, index);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        child: Scaffold(
            body: Container(
                width: width,
                height: height,
                color: colors.scaffoldColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child:  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        inventoryItems(width),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  ),
                )
            )
        )
    );
  }

}