import 'package:flutter/material.dart';
import 'package:app/pages/UI.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/register.dart';

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
              //login();
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
    //var url=Uri.https('', '/api/authenticate);
    var url=Uri.http('192.168.1.52','/api/authenticate');
    Map<String, String> header={"Content-type":"application/json"};

    String v1='"username":"${username.text}';
    String v2='"password":"${password.text}';

    String jsondata='{$v1, $v2}';
  }
}