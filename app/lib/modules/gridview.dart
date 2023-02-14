import 'package:flutter/material.dart';
import 'package:frankenstein_project/interfaces/module_interface.dart';

class Grid extends StatelessWidget with ModuleInterface{
  final double spaceBetweenColumns = 5;
  final double spaceBetweenRows = 5;
  final int columnsAmount = 2;

  final double containerHeight = 0;
  final double height;

  const Grid({super.key, this.height = 0});

  @override
  double getHeight(){
    return 0;
  }

  @override 
  Widget build(BuildContext context){
    return SizedBox(
      height: containerHeight == 0 ? height : containerHeight,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: spaceBetweenColumns,
          crossAxisSpacing: spaceBetweenRows,
          crossAxisCount: columnsAmount
        ), 
        itemBuilder: ((context, index) {
          return Container(color: Colors.green);
        })
      )
    );
  }
}