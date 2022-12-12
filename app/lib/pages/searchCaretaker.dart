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
  bool owner;

  Caretaker(this.id, this.name, this.pfp, this.since, this.owner);
}

class _SearchCaretakerPageState extends State<SearchCaretakerPage> {
  List rawcaretaker = [];
  List<Caretaker> caretakers = [];
  List<Caretaker> display_list = [];
  String button_result = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCaretaker();
  }

  // update the caretaker displaying list after input the search input
  void updateList(String value) {
    setState(() {
      display_list = caretakers
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  // create a caretaker card displaying caretaker information
  Widget caretakerCard(Caretaker care) {
    if (care.owner == false) {
      setState(() {
        button_result = "Request Service";
      });
    } else {
      setState(() {
        button_result = "Cancel Service";
      });
    }
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
                    Text('Name: ${care.name}',
                        style:
                            TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Text('Caretaker ',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold)),
                        Text('C' + '${care.id}',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[800])),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text('work since: ${care.since}',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.grey[800])),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (care.owner == true) {
                            print('CANCEL C' + '${care.id}');
                            request_caretaker(0);
                            final snackBar = SnackBar(
                              content: Text(
                                  '${care.name}' +
                                      ' will no longer be your caretaker!',
                                  style: const TextStyle(fontSize: 14)),
                              backgroundColor: Colors.red[800],
                              action: SnackBarAction(
                                label: 'Undo',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            print('REQUEST C' + '${care.id}');
                            request_caretaker(care.id);
                            final snackBar = SnackBar(
                              content: Text(
                                  '${care.name}' +
                                      ' is your caretaker from now!',
                                  style: const TextStyle(fontSize: 14)),
                              backgroundColor: Colors.green[800],
                              action: SnackBarAction(
                                label: 'Undo',
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          setState(() {
                            getCaretaker();
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                care.owner == true
                                    ? Colors.red
                                    : Colors.indigo),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(10))),
                        child: Text(button_result)),
                  ],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(care.pfp), radius: 52)
                ],
              ),
            ],
          ),
        ));
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

  // get caretaker from the database
  Future<void> getCaretaker() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var _thiscid = pref.getInt('cid');
    print('NOW ' + '$_thiscid');
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/all-caretaker');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print('==All Available Caretaker==');
    setState(() {
      rawcaretaker = jsonDecode(result);
      caretakers = [];
      for (int i = 0; i < rawcaretaker.length; ++i) {
        bool check = rawcaretaker[i]['id'] == _thiscid;
        //print('$check '+rawcaretaker[i]['fullname']);
        caretakers.add(Caretaker(
            rawcaretaker[i]['id'],
            rawcaretaker[i]['fullname'],
            rawcaretaker[i]['image_url'],
            rawcaretaker[i]['Caretaker_since'],
            check));
      }
      display_list = List.from(caretakers);
    });
  }

  // request service from caretaker
  Future<void> request_caretaker(int cid) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('cid', cid);
    var _hereid = pref.getInt('id');
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/request-caretaker/$_hereid');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata = '{"caretaker":$cid}';
    if (cid == 0) {
      jsondata = '{"caretaker":null}';
    }
    var response = await http.put(url, headers: header, body: jsondata);
    print(response.body);
  }
}
