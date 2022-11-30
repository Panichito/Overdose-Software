import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';

class ProfilePage extends StatefulWidget {
  final Patient patient;
  const ProfilePage(this.patient);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class Record {
  String patientId;
  String medicineId;
  String disease;
  String startDate;
  String endDate;
  int amount;
  String note;

  Record(this.patientId, this.medicineId, this.disease, this.startDate, this.endDate, this.amount, this.note);
}

class Alert {

}

Widget RecordCard(Record record) {
  return Card(
    color: Colors.red[100],
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Disease: ${record.disease}'),
              const SizedBox(height: 8,),
              // it suppose to show a medicine name not id
              Text('Medicine: ${record.medicineId}'),
              const SizedBox(height: 8,),
              Text('Amount: ${record.amount.toString()}'),
              const SizedBox(height: 8,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Start: ${record.startDate}'),
              const SizedBox(height: 8,),
              Text('End: ${record.endDate}'),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ProfilePageState extends State<ProfilePage> {
  List<Record> allRecord = [
    Record('P01', 'M01', 'HIV', '2022-02-22', '2022-04-30', 3, 'chances of surviving is zero'),
    Record('P01', 'M02', 'Cancer', '2022-02-22', '2022-03-30', 1, 'chances of surviving is zero'),
    Record('P01', 'M03', 'Diabetes', '2022-02-22', '2022-03-30', 4, 'chances of surviving is zero'),
    Record('P01', 'M04', 'Covid', '2022-02-22', '2022-03-30', 5, 'chances of surviving is zero'),
  ];

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                // height: 400,
                color: Colors.red,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(widget.patient.name, style: TextStyle(fontSize: 20.0, color: Colors.grey[800], fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 8),
                    Text('Patient ID: P${widget.patient.id}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800], fontStyle: FontStyle.italic)),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.patient.pfp),
                      radius: 80,
                    ),
                    const SizedBox(height: 16),
                    Text('Role: ${widget.patient.usertype}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8),
                    Text('Gender: ${widget.patient.gender}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8),
                    Text('Birthdate: ${widget.patient.birthdate}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8),
                    Text('Email: ${widget.patient.email}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ...allRecord.map((record) => RecordCard(record)).toList(),
                    const SizedBox(height: 8,),
                  ],
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}
