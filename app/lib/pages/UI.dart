import 'package:flutter/material.dart';
import 'package:app/pages/findCaretaker.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/allMedicine.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/addRecord.dart';
import 'package:app/pages/search.dart';
import 'package:app/pages/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UIPage extends StatefulWidget {
  const UIPage({super.key});

  @override
  State<UIPage> createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  var _role;
  int _selectedIndex=0;

  void _onItem(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }

  String fullname='';
  @override
  void initState() {
    // TODO: implement initState
    checkFullname();
  }

  @override
  Widget build(BuildContext context) {
    var pagename=[];
    List<Widget> widgetBottom=[];
    if(_role=='PATIENT') {
      pagename=['Home Page', 'Find Caretaker Page', 'All Medicine'];
      widgetBottom=[HomePage(), FindCaretakerPage(), MyMedsPage()];
    }
    else {  // either caretaker or admin is the stuff
      pagename=['Home Page', 'Find Caretaker Page', 'Add Record Page', 'All Medicine', 'Search Patient'];
      widgetBottom=[HomePage(), FindCaretakerPage(), AddRecordPage(), MyMedsPage(), searchPatientAdv(),];
    }
    return DefaultTabController(
      length: 1,
      initialIndex: 0,
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          title: Text(pagename[_selectedIndex]),
          backgroundColor: Colors.indigo[400],
        ),
        body: TabBarView(children: [
          Center(child: widgetBottom.elementAt(_selectedIndex)),
        ]),
        bottomNavigationBar: _role=='PATIENT' ? buildBottomNavBar() : buildBottomNavBarStaff(),
      ),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Caretaker'),
        BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Med'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItem,
      selectedItemColor: Colors.indigo[800],
      unselectedItemColor: Colors.grey,
    );
  }

  Widget buildBottomNavBarStaff() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Caretaker'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Record'),
        BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Med'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItem,
      selectedItemColor: Colors.indigo[800],
      unselectedItemColor: Colors.grey,
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          //Container(height: 100, color: Colors.indigo[400]),
          UserAccountsDrawerHeader(accountName: Text(fullname), accountEmail: null, decoration: BoxDecoration(color: Colors.indigo[400])),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history_edu),
            title: Text('History'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_open),
            title: Text('Logout'),
            onTap: () {
              logout(context);
            },
          ),
        ],
      )
    );
  }

  Future<void> checkFullname() async {
    final SharedPreferences pref=await SharedPreferences.getInstance();
    final checkvalue=pref.get('token') ?? 0;  // เช็คจาก token ดีกว่า เพราะตอน logout ลบออกแค่ token
    if(checkvalue!=0) {  // get username
      setState(() {
        var fname=pref.getString('first_name');
        var lname=pref.getString('last_name');
        _role=pref.getString('role');
        fullname='Hello, $fname $lname ($_role)';
      });
    }
  }

  logout(BuildContext context) async {
    final prefs=await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
}
