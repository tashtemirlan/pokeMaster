import 'package:flutter/material.dart';

class PokedexPage extends StatefulWidget{
  const PokedexPage({super.key});

  @override
  PokedexPageState createState ()=> PokedexPageState();

}

class PokedexPageState extends State<PokedexPage>{
  @override
  Widget build(BuildContext context) {
    return Text("Pokedex page");
  }

}