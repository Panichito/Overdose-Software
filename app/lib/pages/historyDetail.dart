import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
  //String username="User";

  //@override
  //void initState() {
    // TODO: implement initState
    //super.initState();
    //checkUsername();
  //}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(history.name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        Text(history.timeStamp),
        Image.network(history.imageUrl),
        Text(history.disease),
        Text("Amount : ${history.amount}"),
      ],
    );
  }

  //Future<void> checkUsername() async {
    //final SharedPreferences pref=await SharedPreferences.getInstance();
    //final checkvalue=pref.get('token') ?? 0;
    //if(checkvalue!=0) {  // get username
      //setState(() {
        //var usr_name=pref.getString('username');
        //username="$usr_name";
      //});
    //}
  //}
}