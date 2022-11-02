import 'package:flutter/material.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/UI.dart';
import 'package:shared_preferences/shared_preferences.dart';

var token;  // for storing the user's token
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref=await SharedPreferences.getInstance();
  token=pref.getString('token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overdose+ App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      //home: UIPage(),  // direct to this page first due to more convenient for the coder
      home: token==null ? LoginPage() : UIPage(),
    );
  }
}