import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';

class FindCaretakerPage extends StatefulWidget {
  const FindCaretakerPage({super.key});

  @override
  State<FindCaretakerPage> createState() => _FindCaretakerPageState();
}

// temp caretaker constructor
class Caretaker {
  String id;
  String name;
  String pfp;

  Caretaker(this.id, this.name, this.pfp);
}

class _FindCaretakerPageState extends State<FindCaretakerPage> {
  // temp caretaker list
  static List<Caretaker> caretakers = [
    Caretaker('1', 'John Cena', 'https://image-cdn.essentiallysports.com/wp-content/uploads/John-Cena-Salute.png?width=600'),
    Caretaker('2', 'Billy Herrington', 'https://steamuserimages-a.akamaihd.net/ugc/1758065622195690212/39CC6E1AE7E6769F9D1E98270D21FCCC64AF064C/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true'),
    Caretaker('3', 'Eva Elfie', 'https://i.pinimg.com/736x/3e/53/e7/3e53e755ef19e573c0cad1b3a0c83f3e.jpg'),
  ];

  List<Caretaker> display_list = List.from(caretakers);

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${care.name}', style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                    Text('CaretakerId: ${care.id}', style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(care.pfp),
                      radius: 48,
                    )
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
}