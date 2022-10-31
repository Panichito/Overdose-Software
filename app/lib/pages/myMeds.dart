import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

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
        children: [
          SearchField(
            suggestions: meds.map((e) => SearchFieldListItem(
                e.name,
                item: e,
            )).toList(),
            searchStyle: const TextStyle(
              fontSize: 18,
            ),
            suggestionStyle: const TextStyle(
              fontSize: 18,
            ),
            searchInputDecoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
              contentPadding: EdgeInsets.fromLTRB(8, 16, 8, 16),
            ),
            suggestionsDecoration: const BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.white, width: 8),
                right: BorderSide(color: Colors.white, width: 8),
              ),
            ),
            itemHeight: 40,
            maxSuggestionsInViewPort: 5,
          ),
          Column(
            children: meds.map((med) => medCard(med)).toList(),
          )
        ],
      ),
      //bottomNavigationBar: const NavBar(),
    );
  }
}
