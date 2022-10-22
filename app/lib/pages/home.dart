import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.pink[500],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Text('Flutter ROCK!!'),
      ),
    );
  }
}