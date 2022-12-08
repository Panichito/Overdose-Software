import 'package:app/pages/medicineDetail.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyMedsPage extends StatefulWidget {
  const MyMedsPage({Key? key}) : super(key: key);

  @override
  State<MyMedsPage> createState() => _MyMedsPageState();
}

// medicines constructor
class Medicine {
  String medid;
  String medname;
  String medtype;
  String medinfo;
  String medpic;

  Medicine(this.medid, this.medname, this.medtype, this.medinfo, this.medpic);
}

class _MyMedsPageState extends State<MyMedsPage> {
  List getmeds = [];
  static List<Medicine> meds =
      []; // จะใช้ static ทำไมไม่รู้, แต่อย่าไปแก้ ติดไว้เฟี้ยสๆ
  List<Medicine> display_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicine();
  }

  Widget medCard(Medicine med) {
    /* ไปลองใช้ container
    return Card(
      color: Colors.indigo[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(med.name, style: TextStyle(fontSize: 18.0, color: Colors.grey[800])),
            TextButton(onPressed: () {
            }, child: Text("More")),
          ],
        ),
      )
    ); */
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      height: 124,
      width: 329,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: NetworkImage(med.medpic),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.55), BlendMode.darken)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(med.medname,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          TextButton(
              onPressed: () {
                print('MED INFO');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicineDetail(
                            med.medid,
                            med.medname,
                            med.medtype,
                            med.medinfo,
                            med.medpic)));
              },
              child: Text("More Info",
                  style: TextStyle(color: Colors.indigo[200])))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: noSuggestSearch((value) => update_list(value)),
          ),
          Column(
            children: display_list.map((med) => medCard(med)).toList(),
          )
        ],
      ),
    );
  }

  void update_list(String value) {
    setState(() {
      display_list = meds
          .where((element) =>
              element.medname.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> getMedicine() async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/all-medicine');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print('==GET MEDICINE==');
    setState(() {
      getmeds = jsonDecode(result);
      // mapping the list
      meds = []; // init to empty
      for (int i = 0; i < getmeds.length; ++i) {
        meds.add(Medicine(
            'M' + "${getmeds[i]['id']}",
            getmeds[i]['Medicine_name'],
            getmeds[i]['Medicine_type'],
            getmeds[i]['Medicine_info'],
            getmeds[i]['Medicine_URLPic']));
      }
      display_list = List.from(meds);
    });
  }
}
