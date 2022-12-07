import 'package:flutter/material.dart';

// alert constructor
class Alert {
  String alertId;
  String disease;
  String medName;
  String time;

  Alert(this.alertId, this.disease, this.medName, this.time);
}

class ViewAlert extends StatefulWidget {
  const ViewAlert({Key? key}) : super(key: key);

  @override
  State<ViewAlert> createState() => _ViewAlertState();
}

class _ViewAlertState extends State<ViewAlert> {
  // list of alert temp
  List<Alert> allAlert = [
    Alert('A01', 'Covid', 'Viagra', '16:20'),
    Alert('A02', 'Covid2', 'Viagra2', '16:23'),
    Alert('A03', 'Covid3', 'Viagra3', '16:24'),
  ];

  // text in alert information
  // more convenient when styling
  Widget _alertText(text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 16
      ),
    );
  }

  Widget alertCard(Alert alert) {
    return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _alertText('${alert.medName}'),
                const SizedBox(height: 4,),
                _alertText('Medicine: ${alert.disease}'),
                const SizedBox(height: 4,),
                _alertText('Time: ${alert.time}'),
              ],
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // go to edit page

                    // change information
                  },child: const Text('Edit'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // delete the alert
                    setState(() {
                      allAlert.remove(alert);
                    });
                  },child: const Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            // display alert items
            ...allAlert.map((alert) => alertCard(alert)).toList(),
          ],
        ),
      ),
    );
  }
}
