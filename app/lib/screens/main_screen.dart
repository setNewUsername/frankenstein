import 'package:flutter/material.dart';

import 'package:frankenstein_project/modules/header.dart';
import 'package:frankenstein_project/modules/gridview.dart';
import 'package:frankenstein_project/modules/footer.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: LayoutHandler(),
    );
  }
}

class LayoutHandler extends StatefulWidget{
  const LayoutHandler({super.key});

  @override
  LayoutHandlerState createState() => LayoutHandlerState();
}

class LayoutHandlerState extends State<LayoutHandler>{

  Header header = const Header();
  Grid grid = const Grid();
  Footer footer = const Footer();

  double headerHeight = 0;
  double gridHeight = 0;
  double footerHeight = 0;

  @override
  void initState(){
    super.initState();
    headerHeight = header.getHeight();
    footerHeight = footer.getHeight();
  }

  @override
  void dispose(){
    super.dispose();
  }

  //TODO: add after initState callback
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        header,
        grid,
        footer
      ],
    ); 
  }
}