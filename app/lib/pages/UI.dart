import 'package:flutter/material.dart';
import 'package:app/pages/addMedicine.dart';
import 'package:app/pages/findCaretaker.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/myMeds.dart';

class UIPage extends StatefulWidget {
  const UIPage({super.key});

  @override
  State<UIPage> createState() => _UIPageState();
}

class _UIPageState extends State<UIPage> {
  int _selectedIndex=0;

  void _onItem(int index) {
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetBottom=[HomePage(), FindCaretakerPage(), AddMedicinePage(), MyMedsPage()];
    return DefaultTabController(
      length: 4, 
      initialIndex: 0,
      child: Scaffold(
        drawer: buildDrawer(),
        appBar: AppBar(
          title: Text('เอาชื่อหน้า มาใส่เดี๋ยวมาทำ'),
        ),
        body: TabBarView(children: [
          Center(child: widgetBottom.elementAt(_selectedIndex)),
        ]),
        bottomNavigationBar: buildBottomNavBar(),
      ),
    );
  }

  Widget buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Caretaker'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Record'),
        BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Medicine'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItem,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(height: 100, color: Colors.blue),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Menu 1'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Menu 2'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.folder),
            title: Text('Menu 3'),
            onTap: () {},
          ),
        ],
      )
    );
  }
}