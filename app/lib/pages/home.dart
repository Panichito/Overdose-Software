import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/pages/viewRecord.dart';
import 'package:app/pages/history.dart';
import 'package:app/pages/updateProfile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:app/pages/notification.dart';
import 'package:timezone/data/latest.dart' as tz;

bool _isShow = false;

// patient constructor
class Schedule {
  int alertId;
  String disease;
  String medName;
  String time;
  bool isTake;

  Schedule(this.alertId, this.disease, this.medName, this.time, this.isTake);
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
  bool? cstatus;
  // schedules list
  List getAlert = [];
  List<Schedule> allSchedule = [];
  List<Schedule> scheduleList = [];
  var _role;
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUsername();
    checkAlertState();
    getMyAlerts();
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
  Widget homeButton() {
    return Row(
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
                        builder: (context) => RecordPage(myid, false)));
              },
              elevation: 2.0,
              fillColor: Colors.white,
              child: Icon(
                Icons.edit_note_sharp,
                size: 35.0,
                color: Colors.indigo[400],
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
            SizedBox(height: 5),
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
              onPressed: () async {
                final SharedPreferences pref = await SharedPreferences.getInstance();
                var id = pref.getInt('id');
                var fname = pref.getString('first_name');
                var lname = pref.getString('last_name');
                var bdate = pref.getString('birthdate');
                var gen = pref.getString('gender');
                var pfp = pref.getString('profilepic');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(id, fname, lname, bdate, gen, pfp)));
              },
              elevation: 2.0,
              fillColor: Colors.white,
              child: Icon(
                Icons.manage_accounts,
                size: 35.0,
                color: Colors.indigo[400],
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
            SizedBox(height: 5),
            Text(
              'My Profile',
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
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HistoryPage(myid)));
              },
              elevation: 2.0,
              fillColor: Colors.white,
              child: Icon(
                Icons.history_edu,
                size: 35.0,
                color: Colors.indigo[400],
              ),
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
            ),
            SizedBox(height: 5),
            Text(
              'My History',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.indigo[400],
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (_role == 'CARETAKER' && cstatus != null)
          Column(
            children: [
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    if (cstatus == true) {
                      switchCaretakingStatus("False");
                    }
                    else {
                      switchCaretakingStatus("True");
                    }
                    cstatus = !(cstatus!);
                  });
                  print('Change my caretaking status to -> '+'${cstatus}');
                },
                elevation: 2.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.swipe_vertical_sharp,
                  size: 35.0,
                  color: cstatus! ? Colors.greenAccent[700] : Colors.red[400],
                ),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
              SizedBox(height: 5),
              Text(
                'ON/OFF',
                style: TextStyle(
                    fontSize: 13,
                    color: cstatus! ? Colors.greenAccent[700] : Colors.red[400],
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
      ],
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.indigo[400],
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
                  width: 150,
                  child: Text(
                    username,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }

  Widget scheduleCard(Schedule schedule) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime dt = DateTime.parse(formattedDate + " " + schedule.time).toLocal();
    String formattedTime = DateFormat('kk:mm').format(dt);
    print(allSchedule);

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
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),
                  ),
                  Text('Disease: ${schedule.disease}',
                      style:
                          TextStyle(fontSize: 12.0, color: Colors.grey[700])),
                  const SizedBox(height: 20),
                  Text('Time: ${formattedTime}',
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic)),
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
                      if (schedule.isTake == false) {
                        setAlertStatus(schedule.alertId, "True");
                        // create new history
                        createHistory(schedule.alertId);
                      } else {
                        setAlertStatus(schedule.alertId, "False");
                        // delete existing history
                        clearHistory(schedule.alertId);
                      }
                      schedule.isTake = !schedule
                          .isTake; // เซ็ตไปด้วยเลยเพื่อความรวดเร็ว จะได้ไม่ต้อง reload
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: header()),
              /*Four circle button
            and text"Schedule"
            inside this Column()
          */
              Column(
                children: [
                  Text('My Schedule',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo[400],
                          //fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: noSuggestSearch((value) => updateList(value)),
                  ),
                  Visibility(visible: _isShow, child: homeButton()),
                  /* End of Four Button*/

                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isShow = !_isShow;
                      });
                    },
                    icon: Icon(
                      _isShow ? Icons.expand_less : Icons.expand_circle_down,
                      color: Colors.indigo[400],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ...scheduleList
                      .map((schedule) => scheduleCard(schedule))
                      .toList(),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    )

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
        _role = pref.getString('role');
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
    if(_role == "CARETAKER") {
      print('go to check caretking');
      getCaretakingStatus(myid!);
    }
  }

  Future<void> getMyAlerts() async {
    await getMyId();
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/user-alerts/$myid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print('RECEIVE ALL OF MY ALERT');
    setState(() {
      getAlert = jsonDecode(result);
      allSchedule = [];
      for (int i = 0; i < getAlert.length; ++i) {
        allSchedule.add(Schedule(
            getAlert[i]['id'],
            getAlert[i]['disease'],
            getAlert[i]['medname'],
            getAlert[i]['time'],
            getAlert[i]['isTake']));
      }
      scheduleList =
          List.from(allSchedule); // map all schedule into the display list
      tz.initializeTimeZones();
      notificationService.initNotification();
      if (allSchedule.isNotEmpty) {
        notificationService.showNotification(
            'Daily reminder', "Don't forget to take your medicine today!");
      }
    });
  }

  Future<void> setAlertStatus(int aid, String status) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/update-alert/$aid');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata = '{"Alert_isTake":"$status"}';
    var response = await http.put(url, headers: header, body: jsondata);
    print('Change alert status');
    print(response.body);
  }

  Future<void> createHistory(int aid) async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/add-history');
    Map<String, String> header = {"Content-type": "application/json"};
    DateTime internetTime = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(internetTime);
    String formattedTime = DateFormat.Hms().format(internetTime);
    String v1 = '"alert":$aid';
    String v2 = '"History_takeDate":"$formattedDate"';
    String v3 = '"History_takeTime":"$formattedTime"';
    String jsondata = '{$v1, $v2, $v3}';
    print(jsondata);
    var response = await http.post(url, headers: header, body: jsondata);
    var uft8result = utf8.decode(response.bodyBytes);
    print(uft8result);
  }

  Future<void> clearHistory(int aid) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/delete-history/$aid');
    Map<String, String> header = {"Content-type": "application/json"};
    var response = await http.delete(url, headers: header);
    print('CLEAR TAKEN HISTORY');
    print(response.body);
  }

  Future<void> checkAlertState() async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/latest-history');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      Map<String, dynamic> date = jsonDecode(result);
      print('latest date is ' + date['History_takeDate']);
      DateTime internetTime = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd').format(internetTime);
      if (date['History_takeDate'] != formattedDate) {
        print('RESET ALERT STATUS DAILY!');
        refreshAlertStatus("False");
      }
    });
  }

  Future<void> refreshAlertStatus(String setTo) async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/refresh-alerts');
    Map<String, String> header = {"Content-type": "application/json"};
    String jsondata = '{"Alert_isTake":"$setTo"}';
    var response = await http.put(url, headers: header, body: jsondata);
    var uft8result = utf8.decode(response.bodyBytes);
    print(uft8result);
    setState(() {
      getMyAlerts();
    });
  }

  Future<void> getCaretakingStatus(int myid) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/get-care-status/$myid');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      Map<String, dynamic> currentstatus = jsonDecode(result);
      cstatus = currentstatus['Caretaker_status'];
    });
  }

  Future<void> switchCaretakingStatus(String setTo) async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/switch-care-status/$myid');
    Map<String, String> header = {"Content-type": "application/json"};
    String v1 = '"member":$myid';
    String v2 = '"Caretaker_status":"$setTo"';
    String jsondata = '{$v1, $v2}';
    var response = await http.put(url, headers: header, body: jsondata);
    var uft8result = utf8.decode(response.bodyBytes);
    print(uft8result);
  }
}
