import 'package:flutter/material.dart';
import 'package:app/pages/UI.dart';
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
  var username = TextEditingController(), password = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: ListView(
          children: [
            SizedBox(height: 50),
            Text(
              'Login',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.indigo[400],
                  fontSize: 70),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            Text('User Name'),
            SizedBox(height: 10),
            TextField(
              controller: username,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type your User Name',
                prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(Icons.person)),
              ),
            ),
            SizedBox(height: 30),
            Text('Password'),
            SizedBox(height: 10),
            TextField(
              controller: password,
              obscureText: true,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Type your Password',
                prefixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(Icons.lock)),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  if (username.text.isEmpty || password.text.isEmpty) {
                    setState(() {
                      result = 'Username or password should not be empty!';
                    });
                  } else
                    login();
                },
                child: Text('Login')),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Does not have account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: const Text('Register')),
              ],
            ),
            const SizedBox(height: 30),
            Center(
                child: Text(result,
                    style: TextStyle(color: Colors.red, fontSize: 20))),
          ],
        )),
      ),
    );
  }

  // log into the system
  Future login() async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/authenticate');
    Map<String, String> header = {"Content-type": "application/json"};

    String v1 = '"username":"${username.text}"';
    String v2 = '"password":"${password.text}"';

    String jsondata = '{$v1, $v2}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('LOGIN CHECK');
    print(response.body); // view.py return token

    var resulttext = utf8.decode(response.bodyBytes);
    var result_json = json.decode(resulttext);
    String status = result_json['status'];

    if (status == 'login-succeed') {
      setToken(result_json['token']); // save token into shared preferences
      setUserInfo(
          result_json['id'],
          result_json['first_name'],
          result_json['last_name'],
          result_json['username'],
          result_json['role'],
          result_json['profilepic'],
          result_json['birthdate'],
          result_json['gender'],
          result_json['cid']);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => UIPage()));
    } else if (status == 'login-failed') {
      setState(() {
        result = 'Please try again, your password is incorrect!';
      });
    } else {
      // neither if nor elif means json response wrong
      setState(() {
        result = 'Sorry, this account does not exist in the system!';
      });
    }
  }

  // set user token
  Future<void> setToken(token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  // set user information
  Future<void> setUserInfo(
      id, fname, lname, usr, role, pfp, bdate, gen, cid) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('id', id);
    pref.setInt('cid', cid);
    pref.setString('first_name', fname);
    pref.setString('last_name', lname);
    pref.setString('username', usr);
    pref.setString('role', role);
    pref.setString('birthdate', bdate);
    pref.setString('gender', gen);

    if (pfp == null || pfp == "") pfp = "no image"; // old school method
    pref.setString('profilepic', pfp);
  }
}
