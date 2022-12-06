import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/viewRecord.dart';

class ProfilePage extends StatefulWidget {
  final Patient patient;
  const ProfilePage(this.patient);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class BriefRecord {
  String recordId;
  String patientId;
  String medicineId;
  String disease;

  BriefRecord(this.recordId, this.patientId, this.medicineId, this.disease);
}

Widget recordCard(BriefRecord record) {
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
              Text('RecordId: ${record.recordId}'),
              const SizedBox(height: 8,),
              Text('Disease: ${record.disease}'),
              const SizedBox(height: 8,),
              // it suppose to show a medicine name not id
              Text('Medicine: ${record.medicineId}'),
              const SizedBox(height: 8,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('View Alert'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () => {},
              ),
              TextButton(
                child: const Text('View'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () => {},
              ),
              TextButton(
                child: const Text('Edit'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () => {},
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 24,
          title: const Text('Patient Information'),
          backgroundColor: Colors.indigo[400],
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RecordPage())
                        );
                      },
                      child: const Text('View List of Records'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
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
