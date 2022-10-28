import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:app/pages/navBar.dart';

// temp medicines constructor
class Medicine {
  String name;
  Medicine(this.name);
}

// temp meds list
List<Medicine> meds = [
  Medicine('med1'),
  Medicine('med2'),
  Medicine('med3'),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome Back,',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 48,
            ),
          ],
        ),
        backgroundColor: Colors.cyanAccent[400],
        toolbarHeight: 200,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
            child: SearchField(
              suggestions: meds.map(
                    (e) => SearchFieldListItem(
                  e.name,
                  item: e,
                ),
              ).toList(),
              hint: 'Search Medicine',
              marginColor: Colors.blueGrey[200], // *yawn*
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: const Center(
                // check if schedule exist
                // ** condition not yet implemented **
                child: Text(
                  'No schedule',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}