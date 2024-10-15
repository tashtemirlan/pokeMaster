import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bottom_sheets_folder/poke_ball_buy_bottom_sheet.dart';

class ShopPage extends StatefulWidget{
  const ShopPage({super.key});

  @override
  ShopPageState createState ()=> ShopPageState();

}

class ShopPageState extends State<ShopPage>{

  String showUserMoney = "";

  Widget storeItem(double width, globals.ShopItem shopItem) {
    return Container(
      width: width/2.5,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
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
            shopItem.itemName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors.darkBlack),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          // Item price
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                shopItem.itemPrice,
                style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 5,),
              FaIcon(FontAwesomeIcons.coins , color: colors.goldColor, size: 16,)
            ],
          ),
          SizedBox(height: 8.0),
          // Buy Button
          ElevatedButton(
            onPressed: (){
              viewPokeBallBottomSheet(shopItem);
            },
            style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(colors.searchBoxColor)
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  AppLocalizations.of(context)!.buy_string,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
            )
          ),
        ],
      ),
    );
  }

  Widget storeItems(double width){
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: globals.shopItems.map((item){
        return storeItem(width, item);
      }).toList(),
    );
  }

  void viewPokeBallBottomSheet(globals.ShopItem shopItem) async{
    final result = await showCupertinoModalBottomSheet<int>(
      topRadius: const Radius.circular(40),
      backgroundColor: colors.scaffoldColor,
      context: context,
      expand: false,
      builder: (BuildContext context) {
        return PokeBallBuyBottomSheet(shopItem: shopItem);
      },
    );
    if(result!=null){
      setState(() {
        showUserMoney = result.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showUserMoney = globals.userCoins.toString();
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
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child:  SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  NumberFormat("###,###", "en_US").format(int.parse(showUserMoney)).replaceAll(",", " "),
                                  style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(width: 5,),
                                FaIcon(FontAwesomeIcons.coins , color: colors.goldColor, size: 16,)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            AppLocalizations.of(context)!.store_string,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 20,),
                          storeItems(width)
                        ],
                      ),
                    ),
                )
              ),
            )
        )
    );
  }

}