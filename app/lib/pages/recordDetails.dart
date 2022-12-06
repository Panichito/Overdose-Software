import 'package:app/pages/editRecord.dart';
import 'package:flutter/material.dart';

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
            child: Card(
              color: Colors.red[100],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RecordId: ${record.recordId}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 8,),
                    // should show medicine name instead of id
                    Text(
                      'MedicineId: ${record.medicineId}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      'Disease: ${record.disease}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      'Start Date: ${record.startDate}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      'End Date: ${record.endDate}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      'Amount: ${record.amount.toString()}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      'Note: ${record.note}',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
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
                          },
                          child: const Text('Edit'),
                        ),
                        const SizedBox(width: 8,),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            // delete information
                            // placeholderDelete();

                            // go back
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                        const SizedBox(width: 8,),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Complete the Medication'),
                                content: const Text(
                                  'All of the alert of this record will be cleared. Do you wish to proceed?'
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // cancel
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
                                      Navigator.popUntil(context, (route) {
                                        return count++ == 2;
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ]
                              )
                            );
                          },
                          child: const Text('Mark as Complete'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
