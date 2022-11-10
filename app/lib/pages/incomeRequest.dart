import 'package:flutter/material.dart';

// temp patient constructor
class Patient {
  String id;
  String name;
  String pfp;

  Patient(this.id, this.name, this.pfp);
}


class IncomingRequestPage extends StatefulWidget {
  const IncomingRequestPage({Key? key}) : super(key: key);

  @override
  State<IncomingRequestPage> createState() => _IncomingRequestPageState();
}

class _IncomingRequestPageState extends State<IncomingRequestPage> {

  // temp all patient to push into notification list
  List<Patient> allpatient = [
    Patient('3', 'Eva Elfie (sadly, no SFW gif available)',
        'https://jerkmates.com/wp-content/uploads/2020/12/90348184_141484950742488_7660158241977011805_n.jpg'),
    Patient('1', 'John Cena',
        'https://i.kym-cdn.com/photos/images/newsfeed/001/797/816/d51.gifv'),
    Patient('2', 'Billy Herrington',
        'https://media.tenor.com/kRulzDQNGBMAAAAC/gachi-billy-herrington.gif'),
    Patient('4', 'Ricardo Milos',
        'https://i.pinimg.com/originals/38/e5/26/38e5262d801737950f5204669aeff197.gif'),
    Patient('5', 'Danny Lee',
        'https://media.tenor.com/HBJjqZAw-RcAAAAC/super-kazuya-danny-lee.gif'),
    Patient('6', 'Van Darkholme (Leather)',
        'https://steamuserimages-a.akamaihd.net/ugc/787497987679529464/E877A1FF9945D9F70E006E9C94F3A4679E51166F/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false'),
    Patient('7', 'Van Darkholme (Holiday Edition)',
        'https://c.tenor.com/XrbWCFHfJVsAAAAC/gachi-happy-new-year.gif'),
  ];

  @override
  Widget requestCard(Patient patient) {
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
                    Text('Name: ${patient.name}', style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
                    SizedBox(height: 4),
                    Text('Patient-id: P'+'${patient.id}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              // acceptRequest()
                              setState(() {
                                allpatient.remove(patient);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.green[900],
                            ),
                            child: const Text('Accept')),
                        const SizedBox(width: 4,),
                        ElevatedButton(
                            onPressed: () {
                              // declineRequest()
                              setState(() {
                                allpatient.remove(patient);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.grey[700],
                            ),
                            child: const Text('Decline')),
                      ],
                    ),

                  ],
                ),
              ),
              Column(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(patient.pfp), radius: 60)
                ],
              ),
            ],
          ),
        )
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Incoming Requests'), backgroundColor: Colors.indigo[400]),
      body: ListView(
        children: [
          ...allpatient.map((patient) => requestCard(patient)).toList(),
          const SizedBox(height: 16,)
        ],
      ),

    );
  }
}
