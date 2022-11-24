import 'package:flutter/material.dart';
import 'package:app/pages/noSuggestSearch.dart';
import 'package:shared_preferences/shared_preferences.dart';

// temp patient constructor
class Schedule {
  String id;
  String recordId;
  String time;
  String medicine;
  int amount;
  bool isTaken = false;

  Schedule(this.id, this.recordId, this.time, this.medicine, this.amount);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username="", profilepic="https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg";

  List<Schedule> allSchedule = [
    Schedule('1', '1', '12:34', 'Ya Ba', 69),
    Schedule('2', '1', '12:34', 'Ya Ma', 13),
    Schedule('3', '1', '12:34', 'Ya E', 11),
    Schedule('4', '1', '12:34', 'Ya Tum yang nee', 1),
    Schedule('5', '1', '12:34', 'Mai wa gub krai', 2),
    Schedule('6', '1', '12:34', 'Kao jai mai?', 3),
    Schedule('7', '1', '12:34', 'Bird Thongchai', 4),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUsername();
  }

  @override
  Widget scheduleCard(Schedule schedule) {
    return Card(
      color: schedule.isTaken?
        Colors.green[100]:
        Colors.red[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(schedule.medicine, style: TextStyle(fontSize: 32.0, color: Colors.grey[800])),
                Text('Amount: ${schedule.amount}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                const SizedBox(height: 20),
                Text('Time: ${schedule.time}', style: TextStyle(fontSize: 20.0, color: Colors.grey[800])),
                // const SizedBox(height: 4),
                // Text('Schedule-id: S${schedule.id}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
                // const SizedBox(height: 4),
                // Text('Record-id: R${schedule.recordId}', style: TextStyle(fontSize: 16.0, color: Colors.grey[800])),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      // set isTaken to false
                      setState(() {
                        schedule.isTaken = !schedule.isTaken;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.grey[700],
                    ),
                    child: !schedule.isTaken?
                      const Text('Take', style: TextStyle(fontSize: 20),):
                      const Text('Untake', style: TextStyle(fontSize: 20),),
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
          Container(
            height: 200,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            decoration: BoxDecoration(
              color: Colors.indigo[200],
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Welcome Back,', style: TextStyle(fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 10),
                    Text(username, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],

                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(profilepic),
                  radius: 50,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: noSuggestSearch((value) => null),
          ),
          Expanded(
            child: ListView(
              children: [
                ...allSchedule.map((schedule) => scheduleCard(schedule)).toList(),
                const SizedBox(height: 16,)
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const bot(),
    );
  }

  Future<void> checkUsername() async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    final checkvalue=pref.get('token') ?? 0;
    if(checkvalue!=0) {  // get username
      setState(() {
        var usr_name=pref.getString('username');
        var profile_url=pref.getString('profilepic');
        username="$usr_name";
        print(profile_url);
        if(profile_url!="no image") {
          profilepic="$profile_url";
        }
      });
    }
  }
}