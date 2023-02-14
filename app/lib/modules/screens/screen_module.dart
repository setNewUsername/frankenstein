import 'package:flutter/material.dart';
import 'package:frankenstein_project/core/screen_imports.dart';

class Screen extends StatelessWidget{
  final String screenName = "Screen_name" /*<screen_name>*/;

  const Screen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: BaseLayout(),
    );
  }
}

class BaseLayout extends StatefulWidget{
  const BaseLayout({super.key});

  @override
  BaseLayoutState createState() => BaseLayoutState();
}

class BaseLayoutState extends State<BaseLayout>{

  /*!header_var_declaration!*/
  /*!body_var_declaration!*/
  /*!footer_var_declaration!*/

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      /*#header_var_placement#*/
      /*#body_var_placement#*/
      /*#footer_var_placement#*/
    );
  }
}