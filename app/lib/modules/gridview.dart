import 'package:flutter/material.dart';
import 'package:frankenstein_project/interfaces/module_interface.dart';

class Grid extends StatelessWidget with ModuleInterface{
  const Grid({super.key});

  @override
  double getHeight(){
    return 0;
  }

  @override 
  Widget build(BuildContext context){
    return SizedBox(
      height: 0/*<container_height>*/,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5/*<space_petween_columns>*/,
          crossAxisSpacing: 5/*<space_petween_rows>*/,
          crossAxisCount: 2/*<columns_amount>*/
        ), 
        itemBuilder: ((context, index) {
          return Container(color: Colors.green);
        })
      )
    );
  }
}