import 'package:flutter/material.dart';
import 'package:app/pages/navBar.dart';

class MyMedsPage extends StatefulWidget {
  const MyMedsPage({Key? key}) : super(key: key);

  @override
  State<MyMedsPage> createState() => _MyMedsPageState();
}

// temp medicines constructor
class Medicine {
  String name;
  Medicine(this.name);
}

class _MyMedsPageState extends State<MyMedsPage> {
// temp meds list
  List<Medicine> meds = [
    Medicine('med1'),
    Medicine('med2'),
    Medicine('med3'),
  ];

  Widget medCard(Medicine med) {
    return Card(
      color: Colors.indigo[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(med.name, style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: meds.map((med) => medCard(med)).toList(),
      ),
      //bottomNavigationBar: const NavBar(),
    );
  }
}
