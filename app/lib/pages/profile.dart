import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';

class ProfilePage extends StatelessWidget {
  final Patient patient;
  const ProfilePage({super.key, required this.patient});

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
 