import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


// patient constructor
class Patient {
  String id;
  String name;
  String email;
  String gender;
  String usertype;
  String birthdate;
  String pfp;

  Patient(this.id, this.name, this.email, this.gender, this.usertype, this.birthdate, this.pfp);
}

List rawpatient = [];
List<Patient> allpatient = [];

class SearchPatientAdv extends StatefulWidget {
  const SearchPatientAdv({super.key});

  @override
  State<SearchPatientAdv> createState() => _SearchPatientState();
}

// This should be in a new module
class NewScreen extends StatelessWidget {
  final Patient patient;
  const NewScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Text('Patient Information'),
        backgroundColor: Colors.indigo[400]
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text(patient.name, style: TextStyle(fontSize: 20.0, color: Colors.grey[800], fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 10),
                    Text('Patient ID: P${patient.id}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800], fontStyle: FontStyle.italic)),
                    const SizedBox(height: 10),
                    CircleAvatar(
                      backgroundImage: NetworkImage(patient.pfp),
                      radius: 80,
                    ),
                    const SizedBox(height: 15),
                    Text('Role: ${patient.usertype}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 10),
                    Text('Gender: ${patient.gender}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 10),
                    Text('Birthdate: ${patient.birthdate}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 10),
                    Text('Email: ${patient.email}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                  ])),
        ),
      ),
    );
  }
}

class _SearchPatientState extends State<SearchPatientAdv> {
  var caretakerid;
  List<Patient> display_list=[];  // list of display patients

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyPatient();
  }

  void updateList(String value) {
    setState(() {
      display_list = allpatient.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  Widget patientCard(Patient patient) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(patient.pfp),
                    radius: 22,
                  ),
                ],
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Name: ${patient.name}', style: TextStyle(fontSize: 13.0, color: Colors.grey[800])),
                      Text('patient-id: P${patient.id}', style: TextStyle(fontSize: 11.0, color: Colors.grey[800])),
                    ],
                  ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    child: const Text('View Profile'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        // should create a new profile module file
                          builder: (context) => NewScreen(patient: patient)));
                    },
                  ),
                ],
              )
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
    final SharedPreferences pref=await SharedPreferences.getInstance();
    var id=pref.getInt('id');
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/ask-caretakerid/$id');
    var response=await http.get(url);
    var result=utf8.decode(response.bodyBytes);
    print('my staff id');
    print(result);
    setState(() {
      caretakerid=result;
    });
  }

  Future<void> getMyPatient() async {
    await getCaretakerID();
    var url=Uri.https('weatherreporto.pythonanywhere.com', '/api/get-mypatient/$caretakerid');
    var response=await http.get(url);
    var result=utf8.decode(response.bodyBytes);
    print(url);
    print('For search my patient');
    print(result);
    setState(() {
      rawpatient=jsonDecode(result);
      if(rawpatient.length>0) {
        allpatient=[];
        for(int i=0; i<rawpatient.length; ++i) {
          allpatient.add(Patient('${rawpatient[i]['pid']}', rawpatient[i]['name'], rawpatient[i]['email'], 
          rawpatient[i]['gender'], rawpatient[i]['usertype'], rawpatient[i]['birthdate'], rawpatient[i]['profilepic']));
        }
        display_list=List.from(allpatient);
      }
    });
  }
}
