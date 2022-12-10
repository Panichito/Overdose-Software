import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class History {
  String medicine;
  String date;
  String time;
  History(this.medicine, this.date, this.time);
}

class HistoryPage extends StatefulWidget {
  //const HistoryPage({super.key});
  final uid;
  HistoryPage(this.uid);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  List rawHistory = [];
  List<History> histories = [];

  // List of time to be display inside a datecard
  List<History> displayList = [];

  // unique date for displaying in dateCard
  List<String> dateOfHistories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory(widget.uid);
  }

  // A card displaying history
  Widget dateCard(String date) {
    // get only histories of the same date
    displayList.clear();
    for(var elem in histories) {
      if (elem.date == date) {
        displayList.add(elem);
      }
    }
    return Card(
      color: Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text('Date: $date', style: TextStyle(fontSize: 15)),
            for(var history in displayList) timeCard(history),
          ],
        ),
      ),
    );
  }

  // A card inside dateCard displaying each time a patient is taking medicine
  Widget timeCard(History history) {
    return Card(
      color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Text('Date: ${history.date}'),
            // const SizedBox(width: 16,),
            Column(
              children: [
                Text('Took at ${history.time}', style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
            const SizedBox(width:24,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Medicine: ${history.medicine}', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.indigo[400]
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          children: [
            // display dateCard according to number of elements in dateOfHistories
            for(var date in dateOfHistories) dateCard(date),
          ],
        ),
      )
    );
  }

  Future<void> getHistory(int uid) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/get-user-history/$uid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      rawHistory = jsonDecode(result);
      histories = [];
      Set<String> dateSet = {};
      for (int i = 0; i < rawHistory.length; ++i) {
        histories.add(History(rawHistory[i]['medname'], rawHistory[i]['takeDate'], rawHistory[i]['takeTime']));
        dateSet.add(rawHistory[i]['takeDate']);
      }
      dateOfHistories = dateSet.toList();
    });
  }
}
