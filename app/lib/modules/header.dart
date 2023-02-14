import 'package:flutter/material.dart';
import 'package:frankenstein_project/interfaces/module_interface.dart';

class Header extends StatelessWidget with ModuleInterface{
  final double containerHeight = 100;
  
  const Header({super.key});

  @override
  double getHeight(){
    return containerHeight;
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: containerHeight,
      color: Colors.red,
    );
  }
}