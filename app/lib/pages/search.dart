import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:app/pages/home.dart';

// temp caretaker constructor
class Patient {
  String id;
  String name;
  String pfp;

  Patient(this.id, this.name, this.pfp);
}

List<Patient> allpatient = [
  Patient('1', 'John Cena',
      'https://image-cdn.essentiallysports.com/wp-content/uploads/John-Cena-Salute.png?width=600'),
  Patient('2', 'Billy Herrington',
      'https://steamuserimages-a.akamaihd.net/ugc/1758065622195690212/39CC6E1AE7E6769F9D1E98270D21FCCC64AF064C/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true'),
  Patient('3', 'Eva Elfie',
      'https://i.pinimg.com/736x/3e/53/e7/3e53e755ef19e573c0cad1b3a0c83f3e.jpg'),
  Patient('4', 'Evan Alfred',
      'https://i.pinimg.com/736x/3e/53/e7/3e53e755ef19e573c0cad1b3a0c83f3e.jpg'),
];

class searchPatientAdv extends StatefulWidget {
  const searchPatientAdv({super.key});

  @override
  State<searchPatientAdv> createState() => _searchPatientState();
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

class NewScreen extends StatelessWidget {
  final Patient patient;
  const NewScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Text('Patient Information'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(patient.pfp),
                      radius: 48,
                    ),
                    Text('Name: ${patient.name}',
                        style:
                            TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                  ])),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

class _searchPatientState extends State<searchPatientAdv> {
  // temp caretaker list
  List<Patient> patient = allpatient;

  Widget caretakerCard(Patient patient) {
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
                    radius: 20,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Name: ${patient.name}',
                      style:
                          TextStyle(fontSize: 12.0, color: Colors.grey[800])),
                  Text('CaretakerId: ${patient.id}',
                      style:
                          TextStyle(fontSize: 12.0, color: Colors.grey[800])),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    child: const Text('View Profile'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewScreen(patient: patient)));
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SearchField(
              suggestions: patient
                  .map((e) => SearchFieldListItem(
                        e.name,
                        item: e,
                      ))
                  .toList(),
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
          ),
          Column(
            children: patient.map((med) => caretakerCard(med)).toList(),
          )
        ],
      ),
    );
  }
}
