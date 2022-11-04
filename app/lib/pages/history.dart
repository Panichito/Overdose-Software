import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:app/pages/navBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final void Function() onItem;

  const HistoryPage(this.onItem, {super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String username="User";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (
          ListView.builder(itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.access_time_filled_sharp),
              title : Text(histories[index].name),
              subtitle: Text(histories[index].timeStamp),
              trailing: Icon(Icons.search),
              onTap: () {
                widget.onItem();
                },
            );
          },
            itemCount: histories.length,
          )
      )
    );
  }

  Future<void> checkUsername() async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    final checkvalue=pref.get('token') ?? 0;
    if(checkvalue!=0) {  // get username
      setState(() {
        var usr_name=pref.getString('username');
        username="$usr_name";
      });
    }
  }
}