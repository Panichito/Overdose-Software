import 'package:flutter/material.dart';

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
    _v1=widget.v1;
    _v2=widget.v2;
    _v3=widget.v3;
    _v4=widget.v4;
    _v5=widget.v5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_v2+" Infomation"), backgroundColor: Colors.indigo[400]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(child: Text(_v2, style: TextStyle(fontSize: 35, color: Colors.grey[700], fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))),
            SizedBox(height: 5),
            Center(child: Text("Medicine ID: "+_v1, style: TextStyle(fontSize: 15, color: Colors.grey[600], fontStyle: FontStyle.italic))),
            SizedBox(height: 5),
            Center(child: Text("Type: "+_v3, style: TextStyle(fontSize: 15, color: Colors.grey[600], fontStyle: FontStyle.italic))),
            SizedBox(height: 10),
            Image.network(_v5),
            SizedBox(height: 10),
            Text(_v4)
          ],
        ),
      ),
    );
  }
}