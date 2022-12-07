import 'package:flutter/material.dart';
import 'package:app/pages/editRecord.dart';
import 'package:app/pages/viewAlert.dart';

class RecordDetailsPage extends StatefulWidget {
  const RecordDetailsPage({Key? key}) : super(key: key);

  @override
  State<RecordDetailsPage> createState() => _RecordDetailsPageState();
}

class RecordInformation {
  String recordId;
  String medicineId;
  String disease;
  String startDate;
  String endDate;
  int amount;
  String note;

  RecordInformation(this.recordId, this.medicineId, this.disease, this.startDate, this.endDate, this.amount, this.note );
}

class _RecordDetailsPageState extends State<RecordDetailsPage> {
  RecordInformation record = RecordInformation('P01', 'M01', 'HIV', '2022-02-22', '2022-04-30', 3, 'chances of surviving is zero');

  // text in record information
  // more convenient when styling
  Widget _recordInfoText(text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16
      ),
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
                        _recordInfoText('RecordId: ${record.recordId}'),
                        const SizedBox(height: 8,),
                        // should show medicine name instead of id
                        _recordInfoText('MedicineId: ${record.medicineId}'),
                        const SizedBox(height: 8,),
                        _recordInfoText('Disease: ${record.disease}'),
                        const SizedBox(height: 8,),
                        _recordInfoText('Start Date: ${record.startDate}'),
                        const SizedBox(height: 8,),
                        _recordInfoText('End Date: ${record.endDate}'),
                        const SizedBox(height: 8,),
                        _recordInfoText('Amount: ${record.amount.toString()}'),
                        const SizedBox(height: 8,),
                        _recordInfoText('Note: ${record.note}'),
                        const SizedBox(height: 16,),
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
                                  MaterialPageRoute(builder: (context) => EditRecordPage())
                                );
                                // change information
                              },child: const Text('Edit'),
                            ),
                            const SizedBox(width: 8,),
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
                                    title: const Text('Delete this Record'),
                                    content: const Text(
                                        'All of the alert of this record will be cleared. Do you wish to proceed?'
                                    ),
                                    actions: [
                                      TextButton(
                                        // cancel
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        // delete information
                                        // placeholderDelete();

                                        // pop to RecordPage
                                        onPressed: () {
                                          int count = 0;
                                          Navigator.popUntil(context, (route) {
                                            return count++ == 2;
                                          });
                                        },child: const Text('OK'),
                                      ),
                                    ]
                                  )
                                );
                              },child: const Text('Delete'),
                            ),
                            const SizedBox(width: 8,),
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
                                    title: const Text('Complete the Medication'),
                                    content: const Text(
                                      'All of the alert of this record will be cleared. Do you wish to proceed?'
                                    ),
                                    actions: [
                                      TextButton(
                                        // cancel
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        // mark the record complete
                                        // placeholderComplete();

                                        // pop to RecordPage
                                        onPressed: () {
                                          int count = 0;
                                          Navigator.popUntil(context, (route) {
                                            return count++ == 2;
                                          });
                                        },child: const Text('OK'),
                                      ),
                                    ]
                                  )
                                );
                              },child: const Text('Mark as Complete'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // showing list of alert
                ViewAlert(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
