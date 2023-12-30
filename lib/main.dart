import 'dart:math';

import 'package:calculator/screen/calculate.dart';
import 'package:calculator/screen/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 239, 255, 159),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
           bodyText2: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color:const Color.fromARGB(255, 21, 101, 167),
          ),
        ),
      ),
      routes:{
        login.MaterialRoute:(context)=>login(),
        clac.materialRoute:(context)=>clac(),
      },
      home:login(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      );
  }
}
