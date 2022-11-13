import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyMedsPage extends StatefulWidget {
  const MyMedsPage({Key? key}) : super(key: key);

  @override
  State<MyMedsPage> createState() => _MyMedsPageState();
}

// medicines constructor
class Medicine {
  String name;

  Medicine(this.name);
}

class _MyMedsPageState extends State<MyMedsPage> {
  List getmeds = [];
  static List<Medicine> meds = [];  // จะใช้ static ทำไมไม่รู้, แต่อย่าไปแก้ ติดไว้เฟี้ยสๆ
  List<Medicine> display_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicine();
  }

  void updateList(String value) {
    setState(() {
      display_list = meds.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: noSuggestSearch((value) => updateList(value)),
          ),
          Column(
            children: display_list.map((med) => medCard(med)).toList(),
          )
        ],
      ),
    );
  }

  Future<void> getMedicine() async {
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/all-medicine');
    var response=await http.get(url);
    var result=utf8.decode(response.bodyBytes);
    print('==GET MEDICINE==');
    setState(() {
      getmeds=jsonDecode(result);
      // mapping the list
      meds=[];  // init to empty
      for(int i=0; i<getmeds.length; ++i) {
        meds.add(Medicine('M'+"${getmeds[i]['id']}"+' - '+getmeds[i]['Medicine_name']));
      }
      display_list=List.from(meds);
    });
  }
}
