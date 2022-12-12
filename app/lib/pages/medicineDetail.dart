import 'package:flutter/material.dart';
import 'package:app/pages/searchPatient.dart';

class MedicineDetail extends StatefulWidget {
  final v1, v2, v3, v4, v5;
  MedicineDetail(this.v1, this.v2, this.v3, this.v4, this.v5);

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  var _v1, _v2, _v3, _v4, _v5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    _v4 = widget.v4;
    _v5 = widget.v5;
  }

  /* display medicine information */
  Widget content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Container(
              width: SizeConfig.screenWidth * 0.75,
              child: Text(_v2,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.indigo[400],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'QuickSand'))),
        ),
        Row(children: [
          Text("Medicine ID: ",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold)),
          Text(_v1,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              )),
        ]),
        SizedBox(height: 5),
        Row(children: [
          Text("Medicine Type: ",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold)),
          Text(_v3,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              )),
        ]),
        SizedBox(height: 20),
        Image.network(_v5),
        SizedBox(height: 20),
        Text(_v4)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_v2 + " Infomation"),
          backgroundColor: Colors.indigo[400]),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            content(),
          ],
        ),
      ),
    );
  }
}
