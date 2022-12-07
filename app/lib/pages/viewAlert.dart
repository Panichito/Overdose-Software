import 'package:flutter/material.dart';

class ViewAlert extends StatefulWidget {
  const ViewAlert({Key? key}) : super(key: key);

  @override
  State<ViewAlert> createState() => _ViewAlertState();
}

class _ViewAlertState extends State<ViewAlert> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Card(
        child: Text('test123'),
      ),
    );
  }
}
