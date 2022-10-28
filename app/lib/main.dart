import 'package:flutter/material.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/myMeds.dart';
import 'package:app/pages/UI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overdose+ App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}