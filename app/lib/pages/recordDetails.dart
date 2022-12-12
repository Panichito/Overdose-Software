import 'package:flutter/material.dart';
import 'package:app/pages/editRecord.dart';
import 'package:app/pages/searchPatient.dart';
import 'package:app/pages/viewAlert.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// record information constructor
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
      this.amount,
      this.startDate,
      this.endDate,
      this.note);
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
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    _v4 = widget.v4;
    _v5 = widget.v5;
    _v6 = widget.v6;
    _v7 = widget.v7;
    _v8 = widget.v8;
    _v9 = widget.v9;
    _v10 = widget.v10;
    record =
        RecordInformation(_v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8, _v9, _v10);
  }

  // textStyle in record information
  // more convenient when styling
  Widget _recordInfoText(text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
    );
  }

  // style using the record information card
  Widget styleForRecordInfoCard(IconData icon, text1, text2) {
    SizeConfig.init(context);
    SizeConfig.mediaQueryData;
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            icon,
            size: 35,
            color: Colors.indigo[400],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            Container(
              width: SizeConfig.screenWidth * 0.60,
              child: Text(text2,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey[800])),
            )
          ],
        )
      ],
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
                  color: Colors.white,
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Record Information',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[400],
                                fontFamily: 'QuickSand')),
                        SizedBox(height: 10),
                        styleForRecordInfoCard(Icons.note_alt, 'Record ID',
                            'R${record!.recordId}'),
                        const SizedBox(
                          height: 12,
                        ),
                        styleForRecordInfoCard(
                            Icons.person, 'Patient', '${record!.patientName}'),
                        const SizedBox(
                          height: 12,
                        ),
                        styleForRecordInfoCard(
                            Icons.sick, 'Disease', '${record!.disease}'),
                        const SizedBox(
                          height: 12,
                        ),
                        styleForRecordInfoCard(Icons.medication, 'Medicine',
                            '${record!.medicineName}'),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _recordInfoText(
                                    'Amount: ${record!.amount.toString()}'),
                                const SizedBox(
                                  height: 6,
                                ),
                                _recordInfoText(
                                    'Start Date: ${record!.startDate}'),
                                const SizedBox(
                                  height: 6,
                                ),
                                _recordInfoText('End Date: ${record!.endDate}'),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            )),
                        styleForRecordInfoCard(
                            Icons.edit_note, 'Note', '${record!.note}'),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.indigo[400],
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
                                  setState(() {
                                    Map<String, dynamic> map =
                                        jsonDecode(value);
                                    record!.medicineId = map['medicine'];
                                    refreshMedName(map['medicine']);
                                    record!.disease = map['Record_disease'];
                                    record!.amount = map['Record_amount'];
                                    record!.startDate = map['Record_start'];
                                    record!.endDate = map['Record_end'];
                                    record!.note = map['Record_info'];
                                    //refreshRecord(record!.recordId);
                                  });
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
                                backgroundColor: Colors.indigo[400],
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
                                                  await markRecordDone(
                                                      record!.recordId,
                                                      record!.patientId,
                                                      record!.medicineId,
                                                      record!.disease);
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
                              child: const Text('Mark as Complete'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red[400],
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
                                                  await deleteRecord(
                                                      record!.recordId);
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

  // refresh medicine name
  Future<void> refreshMedName(int mid) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/medicine-info/$mid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      Map<String, dynamic> medmap = json.decode(response.body);
      record!.medicineName = medmap['Medicine_name'];
    });
  }

  // delete a record
  Future<void> deleteRecord(int rid) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/delete-record/$rid');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print(response.body);
  }

  // mark a record as done
  Future<void> markRecordDone(int rid, int pid, int mid, String disease) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/update-record/$rid');
    Map<String, String> header = {"Content-type": "application/json"};
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
