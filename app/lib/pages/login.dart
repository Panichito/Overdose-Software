import 'package:flutter/material.dart';
import 'package:app/pages/UI.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/register.dart';
// http method packages
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username=TextEditingController(), password=TextEditingController();
  String result='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page'), backgroundColor: Colors.indigo[400]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(child: ListView(
          children: [
            Text('Please sign-in before using our application.'),
            SizedBox(height: 10),
            TextField(
              controller: username,
              decoration: InputDecoration(hintText: 'username'),
            ),
            SizedBox(height: 30),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: 'password'),
            ),
            SizedBox(height: 30),
            ElevatedButton(onPressed: (){
              if(username.text.isEmpty || password.text.isEmpty) {
                setState(() {
                  result='Username or password should not be empty!';
                });
              }
              else login();
            }, child: Text('Login')),
            SizedBox(height: 30),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
            }, child: Text('Register')),
            SizedBox(height: 30),
            Center(child: Text(result, style: TextStyle(color: Colors.red, fontSize: 20))),
          ],
        )),
      ),
    );
  }

  Future login() async {
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/authenticate');
    //var url=Uri.http('weatherreporto.pythonanywhere.com','/api/authenticate');
    //var url=Uri.http('192.168.1.52:8000','/api/authenticate');
    Map<String, String> header={"Content-type":"application/json"};

    String v1='"username":"${username.text}"';
    String v2='"password":"${password.text}"';

    String jsondata='{$v1, $v2}';
    var response=await http.post(url, headers: header, body: jsondata);
    print('LOGIN CHECK');
    print(response.body);  // view.py return token

    var resulttext=utf8.decode(response.bodyBytes);
    var result_json=json.decode(resulttext);
    String status=result_json['status'];

    if(status=='login-succeed') {
      setToken(result_json['token']);  // save token into shared preferences
      setUserInfo(result_json['first_name'], result_json['last_name'], result_json['username'], result_json['role'], result_json['profilepic']);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>UIPage()));
    }
    else if(status=='login-failed') {
      setState(() {
        result='Invalid username or password!';
      });
    }
    else {  // neither if nor elif means json reponse wrong
      setState(() {
        result='Something is wrong, please try again!';
      });
    }
  }

  Future<void> setToken(token) async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  Future<void> setUserInfo(fname, lname, usr, role, profilepic) async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('first_name', fname);
    pref.setString('last_name', lname);
    pref.setString('username', usr);
    pref.setString('role', role);

    final response=await http.head(Uri.parse(profilepic));
    if(response.statusCode==200) {  // validate URL (maybe not image but nvm)
      pref.setString('profilepic', profilepic);
    }
    else {
      pref.setString('profilepic', "no image");
    }
  }
}