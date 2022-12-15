import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// http method packages
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  final v1, v2, v3, v4, v5, v6;
  const UpdateProfilePage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var _v1, _v2, _v3, _v4, _v5, _v6;
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController bdate = TextEditingController();
  TextEditingController pfp = TextEditingController();
  String? gender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; // id
    _v2 = widget.v2; // first name
    _v3 = widget.v3; // last name
    _v4 = widget.v4; // birth date
    _v5 = widget.v5; // gender
    _v6 = widget.v6; // profile pic
    fname.text = _v2;
    lname.text = _v3;
    bdate.text = _v4;
    gender = _v5;
    pfp.text = _v6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Profile Information'),
          backgroundColor: Colors.indigo[400]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text('First Name'),
            TextField(
              controller: fname,
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
            Text('Last Name'),
            TextField(
              controller: lname,
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
            Text('Gender'),
            genderRadio(),
            SizedBox(height: 30),
            Text('Birthdate'),
            TextField(
                controller: bdate,
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
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(formattedDate);
                    setState(() {
                      bdate.text = formattedDate;
                    });
                  } else {
                    print("Date is not selected");
                  }
                }),
            SizedBox(height: 30),
            Text('Profile Image (URL Only)'),
            TextField(
              // for demo profile url image
              controller: pfp,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(80),
              child: ElevatedButton(
                onPressed: () {
                  send_profile_info();
                  final snackBar = SnackBar(
                      content:
                          const Text('Your information has been updated.'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Text("Update Information",
                    style: TextStyle(color: Colors.white)),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo[400]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* build a gender selector */
  Widget genderRadio() {
    return Row(
      children: [
        Radio(
            value: 'MALE',
            groupValue: gender,
            onChanged: (String? value) {
              setState(() {
                gender = value;
              });
            }),
        Text('Male', style: TextStyle(fontSize: 14)),
        Radio(
            value: 'FEMALE',
            groupValue: gender,
            onChanged: (String? value) {
              setState(() {
                gender = value;
              });
            }),
        Text('Female', style: TextStyle(fontSize: 14)),
      ],
    );
  }

  /* update user's profile and send data to database */
  Future<void> send_profile_info() async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/update-profile/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata =
        '{"first_name":"${fname.text}", "last_name":"${lname.text}", "Member_gender":"$gender", "Member_birthdate":"${bdate.text}", "Member_URLPic":"${pfp.text}"}';
    //print(jsondata);
    var response = await http.put(url, headers: header, body: jsondata);
    print('update profile info here');
    print(response.body);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('first_name', fname.text);
    pref.setString('last_name', lname.text);
    pref.setString('gender', gender!);
    pref.setString('birthdate', bdate.text);
    pref.setString('profilepic', pfp.text);
  }
}
