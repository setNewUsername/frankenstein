import 'package:flutter/material.dart';
import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage3()
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          GridView.custom(
            padding: const EdgeInsets.only(left: 5, right: 5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5
            ),
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: Text('$index', style: const TextStyle(fontSize: 30),),
              );
            }),
          )
        ]
      )
    );
  }
}

class Sliver extends StatelessWidget{
  const Sliver({super.key});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 200,
      child: PageView.builder(
        pageSnapping: true,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: Text('$index', style: const TextStyle(fontSize: 40),),
          );
        },
      )
    ); 
  }
}

class Grid extends StatelessWidget{
  const Grid({super.key});

  @override
  Widget build(BuildContext context){
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index){
        return Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: Text('$index', style: const TextStyle(fontSize: 40),),
        );
      }), 
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
      )
    );
  }
}

class HomePage2 extends StatelessWidget{
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: Sliver()),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              Grid(),
            ],
          ),
          Positioned(
            bottom: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.blue,
            ),
          )
        ],
      )
    );
  }
}

class HomePage3 extends StatelessWidget{
  const HomePage3({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            color: Colors.green,
          ),
          Container(
            height: MediaQuery.of(context).size.height - (200 + 100),
            color: Colors.blue,
            child: const CustomScrollView(
              slivers: [
                Grid(),
              ],
          ),
          ),
          Container(
            height: 100,
            color: Colors.black,
          )
        ],
      )
    );
  }
}