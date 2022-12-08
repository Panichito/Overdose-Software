import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/viewRecord.dart';

class ProfilePage extends StatefulWidget {
  final Patient patient;
  const ProfilePage(this.patient);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
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
                    Text(widget.patient.name,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                    const SizedBox(height: 8),
                    Text('Patient ID: P${widget.patient.id}',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[800],
                            fontStyle: FontStyle.italic)),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.patient.pfp),
                      radius: 80,
                    ),
                    const SizedBox(height: 16),
                    Text('Role: ${widget.patient.usertype}',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8),
                    Text('Gender: ${widget.patient.gender}',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8),
                    Text('Birthdate: ${widget.patient.birthdate}',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                    const SizedBox(height: 8),
                    Text('Email: ${widget.patient.email}',
                        style:
                            TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecordPage(widget.patient.id)));
                      },
                      child: const Text('View list of Records'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ])),
      ),
    );
  }
}
