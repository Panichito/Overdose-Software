import 'package:flutter/material.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/myMeds.dart';


Widget navButton(text, IconData icon) {
  return TextButton(
    onPressed: () {},
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black,
          size: 40,
        ),
        Text(
          '$text',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const DefaultTabController(
    //   length: 5,
    //   child: Scaffold(
    //     bottomNavigationBar: TabBar(
    //       // controller: controller,
    //       tabs: [
    //         Tab(text: 'Home', icon: Icon(Icons.home)),
    //         Tab(text: 'Find Caretaker', icon: Icon(Icons.person)),
    //         Tab(text: 'Add Medicine', icon: Icon(Icons.add)),
    //         Tab(text: 'Health Status', icon: Icon(Icons.bar_chart)),
    //         Tab(text: 'Notification', icon: Icon(Icons.notifications)),
    //       ],
    //     ),
    //     body: TabBarView(
    //       children: [
    //         HomePage(),
    //         HomePage(),
    //         HomePage(),
    //         HomePage(),
    //         HomePage(),
    //       ],
    //     ),
    //   ),
    //
    // );

    return BottomAppBar(
      child: Container(
        height: 80,
        color: Colors.cyanAccent[400],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navButton('Home', Icons.home),
            navButton('Find Caretaker', Icons.person),
            navButton('Add Medicine', Icons.add),
            navButton('Health Status', Icons.bar_chart),
            navButton('My Medicine', Icons.medication),
          ],
        ),
      ),
    );
  }
}