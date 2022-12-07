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

  // convert TimeOfDay to String
  String formatTimeOfDay(TimeOfDay tod) {
    String format;
    format = '${tod.hour.toString()}:${tod.minute.toString().padLeft(2, '0')}';
    return format;
  }

  Widget alertCard(Alert alert) {
    // convert current time from String to TimeOfDay
    TimeOfDay time = TimeOfDay(hour:int.parse(alert.time.split(":")[0]),minute: int.parse(alert.time.split(":")[1]));

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
                  onPressed: () async {
                    // time of new alert
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: time,
                    );
                    // if cancel return
                    if (newTime == null) return;
                    // if ok use new time to edit alert
                    setState(() {
                      // go nuts

                      // change time on the alert
                      alert.time = formatTimeOfDay(newTime);
                    });

                    // change alert information
                    //placeholderUpdateAlert();
                    
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
    TimeOfDay time = TimeOfDay.now();
    return Card(
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'List of all Alerts',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      // time of new alert
                      TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      
                      // if cancel return
                      if (newTime == null) return;
                      
                      // if ok use new time to create new alert
                      setState(() {
                        // go nuts
                        print(newTime);
                      });
                    },child: const Text('Add Alert'),
                  ),
                ],
              ),
            ),
            // display alert items
            ...allAlert.map((alert) => alertCard(alert)).toList(),
          ],
        ),
      ),
    );
  }
}