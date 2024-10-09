import 'package:flutter/material.dart';

import 'package:pokemonmap/ui/global_folder/colors.dart' as colors;

import '../global_folder/globals.dart';

//todo :=> multiple choice radio buttons with check right
class BottomSheetSelectMultipleOptionCheckIconRadioButton extends StatefulWidget{
  final List<CheckBoxItem> listCheckBoxItems;
  final String titleString;
  final String buttonData;
  const BottomSheetSelectMultipleOptionCheckIconRadioButton({super.key, required this.listCheckBoxItems, required this.titleString, required this.buttonData});

  @override
  _BottomSheetSelectMultipleOptionCheckIconRadioButtonState createState() => _BottomSheetSelectMultipleOptionCheckIconRadioButtonState();
}

class _BottomSheetSelectMultipleOptionCheckIconRadioButtonState extends State<BottomSheetSelectMultipleOptionCheckIconRadioButton> {

  Widget createCheckBoxList(width, height){
    return SizedBox(
      width: width*0.85,
      height: height*0.7,
      child: Material(
        child: ListView.builder(
          itemCount: widget.listCheckBoxItems.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(showTypePokemon(widget.listCheckBoxItems[index].type, context)),
              value: widget.listCheckBoxItems[index].itemSelected,
              activeColor: typeColors[widget.listCheckBoxItems[index].type],
              tileColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  widget.listCheckBoxItems[index].itemSelected = value ?? false;
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget button(width){
    return SizedBox(
      width: width*0.85,
      child: ElevatedButton(
          onPressed: ()async{
            Navigator.pop(context, widget.listCheckBoxItems);
          },
          style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(colors.colorBug)
          ),
          child: Text(
              widget.buttonData,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500 , letterSpacing: 0.2
              ))
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: height*0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: width*0.95,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Text(
                      widget.titleString,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 18, color: Color.fromRGBO(30, 30, 30, 1),
                          fontWeight: FontWeight.w600 ,
                          letterSpacing: 0.2, height: 1, decoration: TextDecoration.none
                      )
                  ),
                  const SizedBox(height: 20,),
                  createCheckBoxList(width, height),
                  //add button to apply selected items =>
                  const SizedBox(height: 20,),
                  button(width),
                  const SizedBox(height: 10,),
                ],
              ),
            )
          ],
        )
    );
  }
}