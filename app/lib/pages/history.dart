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

// temp list of history
  List<History> histories = [
    History('Ya Ba', "31-12-2022", "8:00"),
    History('Ya Ba', "31-12-2022", "12:00"),
    History('Ya Ba', "31-12-2022", "18:00"),
    History('Ya Ma', "31-12-2022", "8:00"),
    History('Ya Ma', "31-12-2022", "12:00"),
    History('Ya Ma', "31-12-2022", "18:00"),
    History('Ya Tum Yang Nee', "1-1-2023", "8:00"),
    History('Ya Tum Yang Nee', "1-1-2023", "12:00"),
    History('Ya Tum Yang Nee', "1-1-2023", "18:00"),
    History('Mai Wa Gub Krai', "1-1-2023", "8:00"),
    History('Mai Wa Gub Krai', "1-1-2023", "12:00"),
    History('Mai Wa Gub Krai', "1-1-2023", "18:00"),
    History('Kao Jai Mai?', "2-1-2023", "8:00"),
    History('Kao Jai Mai?', "2-1-2023", "18:00"),
    History('Kao Jai Mai?', "2-1-2023", "12:00"),
    History('Mung Ma Tum Work Duay', "2-1-2023", "8:00"),
    History('Mung Ma Tum Work Duay', "2-1-2023", "12:00"),
    History('Mung Ma Tum Work Duay', "2-1-2023", "18:00"),
  ];

  // List of time to be display inside a datecard
  List<History> displayList = [];

  // unique date for displaying in dateCard
  List<String> dateOfHistories = ["31-12-2022",  "1-1-2023", "2-1-2023"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDate();
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
            Text('Date: $date'),
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
                Text('Time: ${history.time}'),
              ],
            ),
            const SizedBox(width:24,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Medicine: ${history.medicine}'),
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

  Future<void> getAllDate() async {
  }

  Future<void> getHistory(int uid) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/get-user-history/$uid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
    });
  }
}
