import 'package:flutter/material.dart';

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
            navButton('Notification', Icons.notifications),
          ],
        ),

      ),
    );
  }
}