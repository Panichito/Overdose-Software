import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/pages/profile.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    orientation = mediaQueryData.orientation;
  }
}

// patient constructor
class Patient {
  String id;
  String name;
  String email;
  String gender;
  String usertype;
  String birthdate;
  String pfp;

  Patient(this.id, this.name, this.email, this.gender, this.usertype,
      this.birthdate, this.pfp);
}

List rawpatient = [];
List<Patient> allpatient = [];

class SearchPatientAdv extends StatefulWidget {
  const SearchPatientAdv({super.key});

  @override
  State<SearchPatientAdv> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatientAdv> {
  var caretakerid;
  List<Patient> display_list = []; // list of display patients

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyPatient();
  }

  void updateList(String value) {
    setState(() {
      display_list = allpatient
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Widget patientCard(Patient patient) {
    SizeConfig.init(context);
    SizeConfig.mediaQueryData;
    return Card(
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(patient.pfp), radius: 50),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    width: SizeConfig.screenWidth / 2,
                    child: Text('${patient.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text('patient-id: P${patient.id}',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey[800])),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: (ElevatedButton(
                        child: const Text('View Profile'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePage(patient)));
                        },
                      )),
                    ))
              ]),
            ],
          ),
        ));
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
            children: display_list.map((med) => patientCard(med)).toList(),
          )
        ],
      ),
    );
  }

  Future<void> getCaretakerID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getInt('id');
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/ask-caretakerid/$id');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print('my staff id');
    print(result);
    setState(() {
      caretakerid = result;
    });
  }

  Future<void> getMyPatient() async {
    await getCaretakerID();
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/get-mypatient/$caretakerid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(url);
    print('For search my patient');
    print(result);
    setState(() {
      rawpatient = jsonDecode(result);
      if (rawpatient.length > 0) {
        allpatient = [];
        for (int i = 0; i < rawpatient.length; ++i) {
          allpatient.add(Patient(
              '${rawpatient[i]['pid']}',
              rawpatient[i]['name'],
              rawpatient[i]['email'],
              rawpatient[i]['gender'],
              rawpatient[i]['usertype'],
              rawpatient[i]['birthdate'],
              rawpatient[i]['profilepic']));
        }
        display_list = List.from(allpatient);
      }
    });
  }
}
