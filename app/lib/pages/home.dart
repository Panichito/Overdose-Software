import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  String username="User";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
              ),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(username,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],

                ),
                const CircleAvatar(
                  radius: 48,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: noSuggestSearch((value) => null),
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
      // bottomNavigationBar: const bot(),
    );
  }

  Future<void> checkUsername() async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    final checkvalue=pref.get('token') ?? 0;
    if(checkvalue!=0) {  // get username
      setState(() {
        var usr_name=pref.getString('username');
        username="$usr_name";
      });
    }
  }
}