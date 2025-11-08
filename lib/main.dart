import 'package:flutter/material.dart';
import 'dart:math';


void main() {

  runApp(CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int random = 1;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(

      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: width * 0.5,
            height: height * 0.5,
            color:Colors.green,
          ),
          Positioned(
            bottom: -50,
            left: 10,
            child: Container(
              width: width * 0.25,
              height: height * 0.25,
              color:Colors.red,
            ),
          ),
          Positioned(
            right: -10,
            child: Container(
              width: width * 0.2,
              height: height * 0.2,
              color:Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
