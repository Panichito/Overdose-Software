import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/addRecord.dart';

class RecordPage extends StatefulWidget {
  // final Patient patient;
  // const RecordPage(this.patient);

  @override
  State<RecordPage> createState() => _RecordPageState();
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

class _RecordPageState extends State<RecordPage> {
  // List<BriefRecord> allRecord = [
  //   BriefRecord('P01', 'M01', 'HIV', '2022-02-22', '2022-04-30', 3, 'chances of surviving is zero'),
  //   BriefRecord('P01', 'M02', 'Cancer', '2022-02-22', '2022-03-30', 1, 'chances of surviving is zero'),
  //   BriefRecord('P01', 'M03', 'Diabetes', '2022-02-22', '2022-03-30', 4, 'chances of surviving is zero'),
  //   BriefRecord('P01', 'M04', 'Covid', '2022-02-22', '2022-03-30', 5, 'chances of surviving is zero'),
  // ];
  List<BriefRecord> allRecord = [
    BriefRecord('R01','P01', 'M01', 'HIV'),
    BriefRecord('R02', 'P01', 'M02', 'Cancer'),
    BriefRecord('R03', 'P01', 'M03', 'Diabetes'),
    BriefRecord('R04', 'P01', 'M04', 'Covid'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Text('List of Records'),
        backgroundColor: Colors.indigo[400],
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddRecordPage())
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ...allRecord.map((record) => recordCard(record)).toList(),
                  const SizedBox(height: 8,),
                ],
              ),
            ),
          ]
        )
      ),
    );
  }
}

