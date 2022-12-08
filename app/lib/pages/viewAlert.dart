import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// alert constructor
class Alert {
  int alertId;
  String disease;
  String medName;
  String time;
  bool isTake;

  Alert(this.alertId, this.disease, this.medName, this.time, this.isTake);
}

class ViewAlert extends StatefulWidget {
  //const ViewAlert({Key? key}) : super(key: key);
  final rid;
  const ViewAlert(this.rid);

  @override
  State<ViewAlert> createState() => _ViewAlertState();
}

class _ViewAlertState extends State<ViewAlert> {
  var _recordid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recordid = widget.rid;
    getSpecificAlert();
  }

  List getAlert = [];
  List<Alert> allThisAlert = [];

  // text in alert information
  // more convenient when styling
  Widget _alertText(text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
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
    TimeOfDay time = TimeOfDay(
        hour: int.parse(alert.time.split(":")[0]),
        minute: int.parse(alert.time.split(":")[1]));

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
                const SizedBox(
                  height: 4,
                ),
                _alertText('Medicine: ${alert.disease}'),
                const SizedBox(
                  height: 4,
                ),
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
                  },
                  child: const Text('Edit'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    // delete the alert
                    deleteAlert(alert.alertId);
                    setState(() {
                      allThisAlert.remove(alert);
                    });
                  },
                  child: const Text('Delete'),
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
                      await addAlert(newTime);
                      setState(() {
                        print(newTime.format(context));
                        getSpecificAlert();
                      });
                    },
                    child: const Text('Add Alert'),
                  ),
                ],
              ),
            ),
            // display alert items
            ...allThisAlert.map((alert) => alertCard(alert)).toList(),
          ],
        ),
      ),
    );
  }

  Future<void> addAlert(TimeOfDay timetotake) async {
    var url = Uri.https('weatherreporto.pythonanywhere.com', '/api/add-alert');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"record":$_recordid';
    String v2 = '"Alert_time":"${formatTimeOfDay(timetotake)}"';
    String jsondata = '{$v1, $v2}';
    var response = await http.post(url, headers: header, body: jsondata);
    var uft8result = utf8.decode(response.bodyBytes);
    print(uft8result);
  }

  Future<void> deleteAlert(int aid) async {
    var url = Uri.https('weatherreporto.pythonanywhere.com', '/api/delete-alert/$aid');
    Map<String, String> header={"Content-type":"application/json"};
    var response=await http.delete(url, headers: header);
    print(response.body);
  }

  Future<void> getSpecificAlert() async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/record-alerts/$_recordid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    //print(_recordid);
    setState(() {
      getAlert = jsonDecode(result);
      allThisAlert = [];
      for (int i = 0; i < getAlert.length; ++i) {
        allThisAlert.add(Alert(
            getAlert[i]['id'],
            getAlert[i]['disease'],
            getAlert[i]['medname'],
            getAlert[i]['time'],
            getAlert[i]['isTake']));
      }
    });
  }
}
