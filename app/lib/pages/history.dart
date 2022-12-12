import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:app/pages/searchPatient.dart';

// history constructor
class History {
  String medicine;
  String date;
  String time;
  History(this.medicine, this.date, this.time);
}

class HistoryPage extends StatefulWidget {
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

  /* create a container displaying a date when taking medicine */
  Widget dateCard(String date) {
    // get only histories of the same date
    displayList.clear();
    for (var elem in histories) {
      if (elem.date == date) {
        displayList.add(elem);
      }
    }
    DateTime dt = DateTime.parse(date);
    return Container(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
            padding: EdgeInsets.all(5),
            child: Text(DateFormat.yMMMd().format(dt),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        for (var history in displayList) timeCard(history),
      ],
    ));
  }

  /* create a container displaying time when taking medicine */
  Widget timeCard(History history) {
    SizeConfig.init(context);
    SizeConfig.mediaQueryData;
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: SizeConfig.screenWidth * 0.95,
          height: SizeConfig.screenHeight * 0.1,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 12,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12),
                bottom: Radius.circular(12),
              )),
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 20, 10),
                  child: Icon(Icons.access_time)),
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.6,
                        child: Text('Medicine: ${history.medicine}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                      Text(
                        '${history.time}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History of medication'),
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

  /* get history data from the database to display */
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
      //for(var e in dateSet) print(e);
      dateOfHistories = dateSet.toList();
    });
  }
}
