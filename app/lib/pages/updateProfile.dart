import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  final v1, v2, v3, v4, v5, v6;
  const UpdateProfilePage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  var _v1, _v2, _v3, _v4, _v5, _v6;
  TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController bdate=TextEditingController();
  TextEditingController gender=TextEditingController();
  TextEditingController pfp=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1=widget.v1;  // id
    _v2=widget.v2;  // first name
    _v3=widget.v3;  // last name
    _v4=widget.v4;  // birth date
    _v5=widget.v5;  // gender
    _v6=widget.v6;  // profile pic
    fname.text=_v2;
    lname.text=_v3;
    pfp.text=_v6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile Page'),  backgroundColor: Colors.indigo[400]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: fname,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 30),
            TextField(
              controller: lname,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 30),
            TextField(  // for demo profile url image
              controller: pfp,
              decoration: InputDecoration(labelText: 'Profile Image URL (optional)'),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(80),
              child: ElevatedButton(
                onPressed: () {
                },
                child: Text("Edit Information", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber[700]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}