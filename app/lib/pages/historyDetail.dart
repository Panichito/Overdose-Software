import 'package:flutter/material.dart';

class HistoryDetail {
  String name;
  String timeStamp;
  String imageUrl;
  String disease;
  int amount;
  HistoryDetail(this.name, this.timeStamp, this.imageUrl, this.disease, this.amount);
}

HistoryDetail history = HistoryDetail('Pain Killer', "31-12-2022", "https://assets.medpagetoday.net/media/images/95xxx/95471.jpg", "Cancer", 10);

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({super.key});
  @override
  State<HistoryDetailPage> createState() => HistoryDetailPageState();
}

class HistoryDetailPageState extends State<HistoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History'), backgroundColor: Colors.indigo[400]),
      body: Column(
        children: [
          Text(history.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          Text(history.timeStamp),
          Image.network(history.imageUrl),
          Text(history.disease),
          Text("Amount : ${history.amount}"),
        ],
      ),
    );
  }
}
