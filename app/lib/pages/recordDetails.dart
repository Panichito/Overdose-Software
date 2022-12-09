import 'package:flutter/material.dart';
import 'package:app/pages/editRecord.dart';
import 'package:app/pages/viewAlert.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RecordInformation {
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

  RecordInformation(
      this.recordId,
      this.patientId,
      this.medicineId,
      this.patientName,
      this.medicineName,
      this.disease,
      this.amount, this.startDate, this.endDate, this.note);
}

class RecordDetailsPage extends StatefulWidget {
  final v1, v2, v3, v4, v5, v6, v7, v8, v9, v10;
  RecordDetailsPage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6,
      this.v7, this.v8, this.v9, this.v10);

  @override
  State<RecordDetailsPage> createState() => _RecordDetailsPageState();
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  var _v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8, _v9, _v10;
  RecordInformation? record;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1=widget.v1;
    _v2=widget.v2;
    _v3=widget.v3;
    _v4=widget.v4;
    _v5=widget.v5;
    _v6=widget.v6;
    _v7=widget.v7;
    _v8=widget.v8;
    _v9=widget.v9;
    _v10=widget.v10;
    record = RecordInformation(_v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8, _v9, _v10);
  }


  // text in record information
  // more convenient when styling
  Widget _recordInfoText(text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Text('Record Information'),
        backgroundColor: Colors.indigo[400],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: Colors.red[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _recordInfoText('Record ID: R${record!.recordId}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('Patient: ${record!.patientName}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('Medicine: ${record!.medicineName}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('Disease: ${record!.disease}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('Amount: ${record!.amount.toString()}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('Start Date: ${record!.startDate}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('End Date: ${record!.endDate}'),
                        const SizedBox(
                          height: 8,
                        ),
                        _recordInfoText('Note: ${record!.note}'),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                // go to edit page
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRecordPage(
                                            record!.recordId,
                                            record!.patientId,
                                            record!.medicineId,
                                            record!.medicineName,
                                            record!.disease,
                                            record!.startDate,
                                            record!.endDate,
                                            record!.amount,
                                            record!.note))).then((value) {
                                              // เซ็คค่าใหม่
                                            });
                                // change information
                              },
                              child: const Text('Edit'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                // ask for confirmation
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text(
                                                '🗑️ Delete Record!'),
                                            content: const Text(
                                                'All of the alert of this record will be deleted. Do you wish to proceed?'),
                                            actions: [
                                              TextButton(
                                                // cancel
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // delete information
                                                  await deleteRecord(record!.recordId);
                                                  int count = 0;
                                                  // pop to RecordPage
                                                  Navigator.popUntil(context,
                                                      (route) {
                                                    return count++ == 2;
                                                  });
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ]));
                              },
                              child: const Text('Delete'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () {
                                // ask for confirmation
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text(
                                                '⏰ Complete Medication'),
                                            content: const Text(
                                                'All of the alert of this record will be accomplished. Do you wish to proceed?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // cancel
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  // mark the record complete
                                                  await markRecordDone(record!.recordId, record!.patientId, record!.medicineId, record!.disease);
                                                  int count = 0;
                                                  // pop to RecordPage
                                                  Navigator.popUntil(context, (route) {
                                                    return count++ == 2;
                                                  });
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ]));
                              },
                              child: const Text('Mark as Complete'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // showing list of alert
                ViewAlert(record!.recordId),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteRecord(int rid) async {
    var url = Uri.https('weatherreporto.pythonanywhere.com', '/api/delete-record/$rid');
    Map<String, String> header={"Content-type":"application/json"};
    var response=await http.delete(url, headers: header);
    print(response.body);
  }

  Future<void> markRecordDone(int rid, int pid, int mid, String disease) async {
    var url = Uri.https('weatherreporto.pythonanywhere.com', '/api/update-record/$rid');
    Map<String, String> header={"Content-type":"application/json"};
    // required 4 fields
    String v1 = '"patient":$pid';
    String v2 = '"medicine":$mid';
    String v3 = '"Record_disease":"$disease"';
    String v4 = '"Record_isComplete": true';
    String jsondata = '{$v1, $v2, $v3, $v4}';
    var response = await http.put(url, headers: header, body: jsondata);
    print(response.body);
  }
}
