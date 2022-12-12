import 'package:flutter/material.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/UI.dart';
import 'package:shared_preferences/shared_preferences.dart';

var token; // for storing the user's token

/* Main function for running the application and before running it will check if there is a token first or not. 
  The token is the authentication that this user has logged in (each user token is different) */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  // The token will be used to remember that the user has already logged in. If he exits the app, he will not have to waste time logging in again.
  token = pref.getString('token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /* The build function is a function to run the widget which is available in every .dart file (as the main function). */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overdose+ App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      //home: UIPage(),  // direct to this page first due to more convenient for the coder in debugging mode
      home: token == null ? LoginPage() : UIPage(),  // ternary operation of check whether current using has token or not, if not user need to login first!
    );
  }
}
