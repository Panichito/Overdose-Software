import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  String? _radioValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Page'), backgroundColor: Colors.blueAccent[400]),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: ListView(
          children: [
            Center(child: Text('Registration Form')),
            SizedBox(height: 10),
            TextField(
              controller: fname,
              decoration: InputDecoration(hintText: 'first name'),
            ),
            SizedBox(height: 30),
            TextField(
              controller: lname,
              decoration: InputDecoration(hintText: 'last name'),
            ),
            SizedBox(height: 30),
            Text('Select your gender:'),
            genderRadio(),
            SizedBox(height: 15),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: 'Enter Birth Date'
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), //get today's date
                  firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101)
                );
                if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                      setState(() {
                         dateController.text = formattedDate; //set foratted date to TextField value. 
                      });
                  }
                else{
                  print("Date is not selected");
                }
              }
            ),
            SizedBox(height: 30),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'email'),
            ),
            SizedBox(height: 30),
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
            ElevatedButton(onPressed: () {
              register_newuser();
            }, child: Text('Register')),
            SizedBox(height: 30),
          ],
        )),
      ),
    );
  }

  Widget genderRadio() {
    return Row(
      children: [
        Radio(value: 'Male', groupValue: _radioValue, onChanged: (String? value) {
          setState(() {
            _radioValue=value;
          });
        }),
        Text('Male', style: TextStyle(fontSize: 14)),
        Radio(value: 'Female', groupValue: _radioValue, onChanged: (String? value) {
          setState(() {
            _radioValue=value;
          });
        }),
        Text('Female', style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Future register_newuser() async {
    var url=Uri.http('','/api/newuser');
    Map<String, String> header={"Content-type":"application/json"};

    String v1='"username":"${username.text}';
    String v2='"password":"${password.text}';
    String v3='"username":"${username.text}';
  }
}