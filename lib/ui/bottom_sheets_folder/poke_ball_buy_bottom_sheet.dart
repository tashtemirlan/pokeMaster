import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../global_folder/globals.dart';

//todo :=> multiple choice radio buttons with check right
class PokeBallBuyBottomSheet extends StatefulWidget{
  final ShopItem shopItem;
  final int totalAmmountMoneyUser;
  const PokeBallBuyBottomSheet({super.key, required this.shopItem, required this.totalAmmountMoneyUser});

  @override
  PokeBallBuyBottomSheetState createState() => PokeBallBuyBottomSheetState();
}

class PokeBallBuyBottomSheetState extends State<PokeBallBuyBottomSheet> {

  int pokeBallCount = 1;
  Timer? _timer;

  String showPokeBalldescripton(){
    if(widget.shopItem.itemName == "Pokeball"){
      //Pokeball
      return AppLocalizations.of(context)!.pokeball_description_string;
    }
    else if(widget.shopItem.itemName == "Great Ball"){
      // Great Ball
      return AppLocalizations.of(context)!.pokeball_great_description_string;
    }
    else if(widget.shopItem.itemName == "Ultra Ball"){
      // Ultra Ball
      return AppLocalizations.of(context)!.pokeball_ultra_description_string;
    }
    else{
      // master ball
      return AppLocalizations.of(context)!.pokeball_master_description_string;
    }
  }

  void _incrementCounter() {
    if (pokeBallCount < 99) {
      setState(() {
        pokeBallCount++;
      });
    }
  }

  void _decrementCounter() {
    if (pokeBallCount > 1) {
      setState(() {
        pokeBallCount--;
      });
    }
  }

  void _startTimer(bool isIncrement) {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (isIncrement) {
        _incrementCounter();
      } else {
        _decrementCounter();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 5.0),
              // Item description
              Text(
                showPokeBalldescripton(),
                style: TextStyle(fontSize: 20, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                "${AppLocalizations.of(context)!.catch_rate_string} : ${widget.shopItem.catchRate}",
                style: TextStyle(fontSize: 20, fontWeight:
                FontWeight.bold, color: colors.darkBlack, decoration: TextDecoration.none),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
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
                              onTap: _decrementCounter,
                              onLongPress: () => _startTimer(false),
                              onLongPressUp: _stopTimer,
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 32,
                                    letterSpacing: 0.02,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            GestureDetector(
                              onTap: _incrementCounter,
                              onLongPress: () => _startTimer(true),
                              onLongPressUp: _stopTimer,
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
                            if(widget.totalAmmountMoneyUser >= pokeBallCount * int.parse(widget.shopItem.itemPrice)){
                              Navigator.pop(context, int.parse(widget.shopItem.itemPrice));
                            }
                            else{
                              Navigator.pop(context);
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: AppLocalizations.of(context)!.low_money_string,
                                  message: AppLocalizations.of(context)!.buy_pokeball_error,
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