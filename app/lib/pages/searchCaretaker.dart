import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SearchCaretakerPage extends StatefulWidget {
  const SearchCaretakerPage({super.key});

  @override
  State<SearchCaretakerPage> createState() => _SearchCaretakerPageState();
}

// caretaker constructor
class Caretaker {
  int id;
  String name;
  String pfp;
  String since;

  Caretaker(this.id, this.name, this.pfp, this.since);
}

// จริงๆต้องมีเคสสำหรับแสดงตอนไม่มี caretaker เลยสักคนด้วย, แต่ปล่อยไปก่อน มันเป็นเรื่องของ UI ไปโฟกัส main features ก่อน
class _SearchCaretakerPageState extends State<SearchCaretakerPage> {
  List rawcaretaker = [];
  List<Caretaker> caretakers = [];
  List<Caretaker> display_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCaretaker();
  }

  void updateList(String value) {
    setState(() {
      display_list = caretakers.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  Widget caretakerCard(Caretaker care) {
    return Card(
        color: Colors.indigo[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${care.name}', style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                      SizedBox(height: 4),
                      Text('caretaker-id: C'+'${care.id}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                      Text('work since: ${care.since}', style: TextStyle(fontSize: 14.0, color: Colors.grey[800])),
                      const SizedBox(height: 8,),
                      ElevatedButton(
                        onPressed: () {
                          print('REQUEST C'+'${care.id}');
                          request_caretaker(care.id);
                          final snackBar = SnackBar(
                            content: Text('${care.name}'+' is your caretaker from now!', style: const TextStyle(fontSize: 14)),
                            backgroundColor: Colors.orange[900],
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Colors.orange[100],
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ButtonStyle(padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10))),
                        child: const Text('Request Service')
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(care.pfp), radius: 52)
                  ],
                ),
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: noSuggestSearch((value) => updateList(value)),
          ),
          Expanded(
            child: ListView(
              children: display_list.map((med) => caretakerCard(med)).toList(),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getCaretaker() async {
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/all-caretaker');
    var response=await http.get(url);
    var result=utf8.decode(response.bodyBytes);
    print('==All Available Caretaker==');
    setState(() {
      rawcaretaker=jsonDecode(result);
      caretakers=[];
      for(int i=0; i<rawcaretaker.length; ++i) {
        caretakers.add(Caretaker(rawcaretaker[i]['id'], rawcaretaker[i]['fullname'], rawcaretaker[i]['image_url'], rawcaretaker[i]['Caretaker_since']));
      }
      display_list=List.from(caretakers);
    });
  }

  Future<void> request_caretaker(int cid) async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    var _hereid=pref.getInt('id');
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/request-caretaker/$_hereid');
    Map<String, String> header={"Content-type":"application/json"};
    String jsondata='{"caretaker":$cid}';
    var response=await http.put(url, headers: header, body: jsondata);
    print(response.body);
  }
}