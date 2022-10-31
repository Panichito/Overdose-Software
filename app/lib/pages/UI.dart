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
    var pagename=['Home Page', 'Find Caretaker Page', 'Add Record Page', 'All Medicine', 'Search Patient'];
    List<Widget> widgetBottom=[HomePage(), FindCaretakerPage(), Text('Add Record Page (for caretaker)'), MyMedsPage(), Text('Search Patient')];
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
        bottomNavigationBar: buildBottomNavBar(),
      ),
    );
  }

  Widget buildBottomNavBar() {
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
          Container(height: 100, color: Colors.indigo[400]),
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
            leading: Icon(Icons.lock_open),
            title: Text('Logout'),
            onTap: () {},
          ),
        ],
      )
    );
  }
}