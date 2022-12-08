import 'package:flutter/material.dart';
import 'package:app/pages/editRecord.dart';
import 'package:app/pages/viewAlert.dart';

class RecordDetailsPage extends StatefulWidget {
  final v1, v2, v3, v4, v5, v6, v7, v8;
  RecordDetailsPage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6, this.v7, this.v8);

  @override
  State<RecordDetailsPage> createState() => _RecordDetailsPageState();
}

class RecordInformation {
  int recordId;
  String patientName;
  String medicineName;
  String disease;
  int amount;
  String startDate;
  String endDate;
  String note;

  RecordInformation(this.recordId, this.patientName, this.medicineName,
      this.disease, this.amount, this.startDate, this.endDate, this.note);
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  var _v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8;
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
    record = RecordInformation(_v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8);
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
                                        builder: (context) =>
                                            EditRecordPage(record!.medicineName, record!.disease, record!.startDate, record!.endDate, record!.amount, record!.note)));
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
                                                'Delete this Record'),
                                            content: const Text(
                                                'All of the alert of this record will be cleared. Do you wish to proceed?'),
                                            actions: [
                                              TextButton(
                                                // cancel
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                // delete information
                                                // placeholderDelete();

                                                // pop to RecordPage
                                                onPressed: () {
                                                  int count = 0;
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
                                                'Complete the Medication'),
                                            content: const Text(
                                                'All of the alert of this record will be accomplished. Do you wish to proceed?'),
                                            actions: [
                                              TextButton(
                                                // cancel
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                // mark the record complete
                                                // placeholderComplete();

                                                // pop to RecordPage
                                                onPressed: () {
                                                  int count = 0;
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
}
