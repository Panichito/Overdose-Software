import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/addRecord.dart';
import 'package:app/pages/recordDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// briefRecord constructor
class BriefRecord {
  int recordId;
  int patientId;
  int medicineId;
  int amount;
  String patientName;
  String medicineName;
  String disease;
  String startDate;
  String endDate;
  String note;

  BriefRecord(
      this.recordId,
      this.patientId,
      this.medicineId,
      this.patientName,
      this.medicineName,
      this.disease,
      this.amount, this.startDate, this.endDate, this.note);
}

class RecordPage extends StatefulWidget {
  final uid, access;
  const RecordPage(this.uid, this.access);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  var _userid, _accessStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userid = widget.uid;
    _accessStatus = widget.access;
    getRecords();
  }

  List getRec = [];
  List<BriefRecord> allRecord = [];

  // create a record card displaying record information
  Widget recordCard(BriefRecord record) {
    SizeConfig.init(context);
    SizeConfig.mediaQueryData;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: SizeConfig.screenWidth * 0.95,
              height: SizeConfig.screenHeight * 0.05,
              decoration: BoxDecoration(
                  color: Colors.indigo[400],
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  )),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(14, 2, 0, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Record R${record.recordId}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ))),
          Container(
              width: SizeConfig.screenWidth * 0.95,
              height: SizeConfig.screenHeight * 0.18,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  )),
              //padding: EdgeInsets.all(1),
              child: Padding(
                padding: EdgeInsets.fromLTRB(14, 10, 10, 5),
                child: Row(
                  children: [
                    Column(children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.65,
                        child: Text(
                          'Disease:',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.65,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Text(
                            '${record.disease}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.005),
                      Container(
                        width: SizeConfig.screenWidth * 0.65,
                        child: Text(
                          'Medicine:',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          width: SizeConfig.screenWidth * 0.65,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Text(
                              '${record.medicineName}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black),
                            ),
                          ))
                    ]),
                    if (_accessStatus)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecordDetailsPage(
                                      record.recordId,
                                      record.patientId,
                                      record.medicineId,
                                      record.patientName,
                                      record.medicineName,
                                      record.disease,
                                      record.amount,
                                      record.startDate,
                                      record.endDate,
                                      record.note))).then((value) {
                            setState(() {
                              getRecords();
                            });
                          });
                        },
                        child: Text('more'),
                      )
                  ],
                ),
              ))
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !_accessStatus
          ? Container()
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRecordPage(_userid)))
                    .then((value) {
                  setState(() {
                    getRecords();
                  });
                });
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
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  // get records from database
  Future<void> getRecords() async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/get-user-records/$_userid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      getRec = jsonDecode(result);
      allRecord = [];
      for (int i = 0; i < getRec.length; ++i) {
        allRecord.add(BriefRecord(
            getRec[i]['rid'],
            getRec[i]['pid'],
            getRec[i]['mid'],
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
