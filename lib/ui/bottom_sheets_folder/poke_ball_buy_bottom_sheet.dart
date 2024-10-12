import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokemonmap/ui/bottom_navigation_folder/shopPage.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemonmap/ui/global_folder/globals.dart' as globals;


import '../global_folder/globals.dart';

//todo :=> multiple choice radio buttons with check right
class PokeBallBuyBottomSheet extends StatefulWidget{
  final ShopItem shopItem;
  const PokeBallBuyBottomSheet({super.key, required this.shopItem,});

  @override
  PokeBallBuyBottomSheetState createState() => PokeBallBuyBottomSheetState();
}

class PokeBallBuyBottomSheetState extends State<PokeBallBuyBottomSheet> {

  int pokeBallCount = 1;

  @override
  void initState() {
    super.initState();
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
              Image.asset(
                widget.shopItem.imagePath,
                height: 80,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 8.0),
              // Item name
              Text(
                widget.shopItem.itemName,
                style: TextStyle(fontSize: 28, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.0),
              // Item price
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.shopItem.itemPrice,
                    style: TextStyle(fontSize: 22, color: Colors.grey[600],
                        fontWeight: FontWeight.w700, decoration: TextDecoration.none),
                  ),
                  const SizedBox(width: 5,),
                  FaIcon(FontAwesomeIcons.coins , color: colors.goldColor, size: 16,)
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: colors.searchBoxColor,
                          borderRadius: BorderRadius.circular(999)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (pokeBallCount > 1) {
                                  setState(() {
                                    pokeBallCount--;
                                  });
                                }
                              },
                              child: FaIcon(
                                FontAwesomeIcons.minus,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text(
                                "$pokeBallCount",
                                style: TextStyle(
                                    color: colors.colorElectric,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                    letterSpacing: 0.02,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            GestureDetector(
                              onTap: () {
                                if (pokeBallCount < 99) {
                                  setState(() {
                                    pokeBallCount++;
                                  });
                                }
                              },
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: (){
                            if(globals.userCoins >= pokeBallCount * int.parse(widget.shopItem.itemPrice)){
                              setState(() {
                                globals.userCoins -= pokeBallCount * int.parse(widget.shopItem.itemPrice);
                              });
                            }
                            else{
                              Fluttertoast.showToast(
                                msg: AppLocalizations.of(context)!.low_money_string,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 12.0,
                              );
                            }
                            Navigator.pop(context, globals.userCoins);
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
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: Text(
                              AppLocalizations.of(context)!.buy_string,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          )
                      )
                  ),
                ],
              ),
              const SizedBox(height: 30,)
            ],
          ),
        )
    );
  }
}