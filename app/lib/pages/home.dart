import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/pages/viewRecord.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// patient constructor
class Schedule {
  String disease;
  String medName;
  String time;
  bool isTake;

  Schedule(this.disease, this.medName, this.time, this.isTake);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "",
      profilepic =
          "https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg";

  int? myid;
  // schedules list
  List getAlert = [];
  List<Schedule> allSchedule = [];
  List<Schedule> scheduleList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUsername();
    getAlerts();
  }

  void updateList(String value) {
    setState(() {
      scheduleList = allSchedule
          .where((element) =>
              element.medName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget scheduleCard(Schedule schedule) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime dt = DateTime.parse(formattedDate + " " + schedule.time).toLocal();
    String formattedTime = DateFormat('kk:mm').format(dt);
    return Card(
      color: schedule.isTake ? Colors.green[100] : Colors.red[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schedule.medName,
                    style: TextStyle(fontSize: 30.0, color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
                  Text('Disease: ${schedule.disease}', style: TextStyle(fontSize: 12.0, color: Colors.grey[700])),
                  const SizedBox(height: 20),
                  Text('Time: ${formattedTime}', style: TextStyle(fontSize: 22.0, color: Colors.grey[700], fontStyle: FontStyle.italic)),
                  // const SizedBox(height: 4),
                  // Text('Schedule-id: S${schedule.id}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                  // const SizedBox(height: 4),
                  // Text('Record-id: R${schedule.recordId}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // set isTaken to false
                    setState(() {
                      schedule.isTake = !schedule.isTake;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: Colors.grey[700],
                  ),
                  child: !schedule.isTake
                      ? const Text(
                          'Take',
                          style: TextStyle(fontSize: 20),
                        )
                      : const Text(
                          'Untake',
                          style: TextStyle(fontSize: 20),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.indigo[500],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24),
                    top: Radius.circular(24),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Welcome Back,',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            )),
                        const SizedBox(height: 5),
                        Container(
                          width: 50,
                          child: Text(
                            username,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 100),
                    CircleAvatar(
                      backgroundImage: NetworkImage(profilepic),
                      radius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          getMyId();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecordPage(myid)));
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.edit_note_sharp,
                          size: 35.0,
                          color: Colors.indigo[400],
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'View Record',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.indigo[400],
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.question_mark,
                          size: 35.0,
                          color: Colors.indigo[400],
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Empty',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.indigo[400],
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.question_mark,
                          size: 35.0,
                          color: Colors.indigo[400],
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Empty',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.indigo[400],
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.question_mark,
                          size: 35.0,
                          color: Colors.indigo[400],
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Empty',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.indigo[400],
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('My Schedule',
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.indigo[400],
                      //fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: noSuggestSearch((value) => updateList(value)),
          ),
          Expanded(
            child: ListView(
              children: [
                ...scheduleList
                    .map((schedule) => scheduleCard(schedule))
                    .toList(),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const bot(),
    );
  }

  Future<void> checkUsername() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final checkvalue = pref.get('token') ?? 0;
    if (checkvalue != 0) {
      // get username
      setState(() {
        var usr_name = pref.getString('username');
        var profile_url = pref.getString('profilepic');
        username = "$usr_name";
        print(profile_url);
        if (profile_url != "no image") {
          profilepic = "$profile_url";
        }
      });
    }
  }

  Future<void> getMyId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    myid = pref.getInt('id');
  }

  Future<void> getAlerts() async {
    await getMyId();
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/get-alerts/$myid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print('RECEIVE MY ALERT LIST');
    setState(() {
      getAlert = jsonDecode(result);
      allSchedule = [];
      for (int i = 0; i < getAlert.length; ++i) {
        allSchedule.add(Schedule(getAlert[i]['disease'], getAlert[i]['medname'],
            getAlert[i]['time'], getAlert[i]['isTake']));
      }
      scheduleList =
          List.from(allSchedule); // add all schedule into the display list
    });
  }
}
