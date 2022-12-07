import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/addRecord.dart';
import 'package:app/pages/recordDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BriefRecord {
  int recordId;
  String patientName;
  String medicineName;
  String disease;
  int amount;
  String startDate;
  String endDate;
  String note;

  BriefRecord(this.recordId, this.patientName, this.medicineName, this.disease,
      this.amount, this.startDate, this.endDate, this.note);
}

class RecordPage extends StatefulWidget {
  final uid;
  const RecordPage(this.uid);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  var _userid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userid=widget.uid;
    getRecords();
  }

  List getRec = [];
  List<BriefRecord> allRecord = [];

  Widget recordCard(BriefRecord record) {
    return Card(
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Record ID: R${record.recordId}'),
                  const SizedBox(height: 8,),
                  Text('Disease: ${record.disease}'),
                  const SizedBox(height: 8,),
                  // it suppose to show a medicine name not id
                  Text('Medicine: ${record.medicineName}'),
                  const SizedBox(height: 8,),
                ],
              ),
            ),
            const SizedBox(width: 16,),
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecordDetailsPage())
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecordPage()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        titleSpacing: 24,
        title: const Text('List of Records'),
        backgroundColor: Colors.indigo[400],
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

  Future<void> getRecords() async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/get-records/$_userid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      getRec = jsonDecode(result);
      print(getRec);
      allRecord = [];
      for (int i = 0; i < getRec.length; ++i) {
        allRecord.add(BriefRecord(
            getRec[i]['id'],
            getRec[i]['patientname'],
            getRec[i]['medname'],
            getRec[i]['disease'],
            getRec[i]['amount'],
            getRec[i]['start'],
            getRec[i]['end'],
            getRec[i]['info']));
      }
    });
  }
}

