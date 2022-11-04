import 'package:flutter/material.dart';
import 'package:app/pages/historyDetail.dart';

class HistoryList {
  String name;
  String timeStamp;
  HistoryList(this.name, this.timeStamp);
}

List<HistoryList> histories = [
  HistoryList('Paracetamol', "31-12-2022"),
  HistoryList('Pain killer', "30-12-2022"),
  HistoryList('Antibiotics', "29-12-2022"),
];

class HistoryPage extends StatefulWidget {
  //final void Function() onItem;  // what is onItem?
  //const HistoryPage(this.onItem, {super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History by Madam Gus'), backgroundColor: Colors.indigo[400]),
      body: Container(
        child: (ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.access_time_filled_sharp),
            title: Text(histories[index].name),
            subtitle: Text(histories[index].timeStamp),
            trailing: Icon(Icons.search),
            onTap: () {
              //widget.onItem();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryDetailPage()));
            },
          );
        },
        itemCount: histories.length,
      ))),
    );
  }
}