import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var fname=TextEditingController();
  var lname=TextEditingController(); 
  var dateController=TextEditingController(); 
  var email=TextEditingController(); 
  var username=TextEditingController();
  var password=TextEditingController();
  var profilepic=TextEditingController();
  String result='';
  String? _radioValue;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
            onPressed: () => Navigator.pop(context, false)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: ListView(
          children: [
            Text(
              'Register',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.indigo[400],
                  fontSize: 70),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),
            Center(
                child: Text('Personal Information',
                    style: TextStyle(fontSize: 20))),
            SizedBox(height: 30),
            /* First Name TextField */
            TextField(
              controller: fname,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'First Name',
              ),
            ),
            SizedBox(height: 30),
            /* Last Name TextField */
            TextField(
              controller: lname,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Last Name',
              ),
            ),
            SizedBox(height: 30),
            /* Email Address TextField */
            TextField(
              controller: email,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email Address',
              ),
            ),
            SizedBox(height: 30),
            Text('Select your gender:'),
            SizedBox(height: 10),
            genderRadio(),
            SizedBox(height: 30),
            TextField(
                controller: dateController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Birthdate'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          1900), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    print(
                        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    print(
                        formattedDate); //formatted date output using intl package =>  2022-07-04
                    //You can format date as per your need

                    setState(() {
                      dateController.text =
                          formattedDate; //set foratted date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                }),
            SizedBox(height: 30),
            Center(
                child: Text('Account Information',
                    style: TextStyle(fontSize: 20))),
            SizedBox(height: 30),
            /* First Name TextField */
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
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 30),
            /* First Name TextField */
            TextField(
              controller: password,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 30),
            Text('Optional:', style: TextStyle(color: Colors.indigo[400])),

            /* First Name TextField */
            SizedBox(height: 10),
            TextField(
              controller: profilepic,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Profile Image URL (Optional)',
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  if (username.text.isEmpty ||
                      password.text.isEmpty ||
                      email.text.isEmpty ||
                      dateController.text.isEmpty ||
                      fname.text.isEmpty ||
                      lname.text.isEmpty) {
                    setState(() {
                      result = 'Please complete all information!';
                    });
                  } else if (!EmailValidator.validate(email.text)) {
                    setState(() {
                      result = 'Invalid email address!';
                    });
                  } else {
                    print(dateController);
                    await register_newuser();
                  }

                  final snackBar = SnackBar(
                      content: Text(
                        result,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor:
                          !success ? Colors.red[900] : Colors.green[900]);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  success = false;
                },
                child: Text('Register')),
          ],
        )),
      ),
    );
  }


  Widget genderRadio() {
    return Row(
      children: [
        Radio(value: 'MALE', groupValue: _radioValue, onChanged: (String? value) {
          setState(() {
            _radioValue=value;
          });
        }),
        Text('Male', style: TextStyle(fontSize: 14)),
        Radio(value: 'FEMALE', groupValue: _radioValue, onChanged: (String? value) {
          setState(() {
            _radioValue=value;
          });
        }),
        Text('Female', style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Future register_newuser() async {
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/newuser');
    //var url=Uri.http('weatherreporto.pythonanywhere.com','/api/newuser');
    //var url=Uri.http('192.168.1.52:8000','/api/newuser');
    Map<String, String> header={"Content-type":"application/json"};

    String v1='"username":"${username.text}"';
    String v2='"password":"${password.text}"';
    String v3='"email":"${email.text}"';
    String v4='"first_name":"${fname.text}"';
    String v5='"last_name":"${lname.text}"';
    String v6='"gender":"$_radioValue"';
    String v7='"birthday":"${dateController.text}"';
    String v8='"profilepic":"${profilepic.text}"';

    String jsondata='{$v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8}';
    var response=await http.post(url, headers: header, body: jsondata);
    print('---register newuser---');
    print(response.body);  // view.py return token

    var resulttext=utf8.decode(response.bodyBytes);
    var result_json=json.decode(resulttext);
    String status=result_json['status'];

    if(status=='account-created') {
      String setresult='Congratulations, ${result_json['first_name']} ${result_json['last_name']}\nYou are already a new member.';
      String token=result_json['token'];
      setToken(token);  // เมื่อได้รับ token แล้ว ให้ทำการบันทึกลงไปในระบบ
      setState(() {
        result = setresult;
        success = true;
      });
    }
    else if(status=='user-exist') {
      setState(() {
        result='Already has this user in our system, please try a new one!';
      });
    }
    else {
      setState(() {
        result='Incorrect information, please check again!';
      });
    }
  }

  Future<void> setToken(token) async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('token', token);
  }
}
