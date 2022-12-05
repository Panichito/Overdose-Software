import 'package:flutter/material.dart';

class Record {
  String name;
  String timeStamp;
  Record(this.name, this.timeStamp);
}

List<Record> records = [
  Record('Patient 1', "31-12-2022"),
  Record('Patient 2', "30-12-2022"),
  Record('Patient 3', "29-12-2022"),
];

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  @override
  State<RecordPage> createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Record'), backgroundColor: Colors.indigo[400]),
      body: Container(
          child: (ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(records[index].name),
            subtitle: Text(records[index].timeStamp),
            trailing: Icon(Icons.search),
            onTap: () {
              //widget.onItem();
            },
          );
        },
        itemCount: records.length,
      ))),
    );
  }
}
