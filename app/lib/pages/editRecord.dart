import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class EditRecordPage extends StatefulWidget {
  final v1, v2, v3, v4, v5, v6, v7, v8, v9;
  EditRecordPage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6, this.v7,
      this.v8, this.v9);

  @override
  State<EditRecordPage> createState() => _EditRecordPageState();
}

class _EditRecordPageState extends State<EditRecordPage> {
  String? jsondata;
  String result = 'Note field can be empty';
  bool success = false;

  var _v1, _v2, _v3, _v4, _v5, _v6, _v7, _v8, _v9;

  // initialize value from the existing record
  String? medId;
  final diseaseController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  // list of patient
  List rawpatient = [];
  var patientList = <String>[];

  // list of medicine
  List rawmed = [];
  var medList = <String>[];

  @override
  void initState() {
    super.initState();
    _v1 = widget.v1;
    _v2 = widget.v2;
    _v3 = widget.v3;
    _v4 = widget.v4;
    _v5 = widget.v5;
    _v6 = widget.v6;
    _v7 = widget.v7;
    _v8 = widget.v8;
    _v9 = widget.v9;
    medId = 'M' + '$_v3' + ': ' + '$_v4';
    diseaseController.text = _v5;
    startDateController.text = _v6;
    endDateController.text = _v7;
    amountController.text = '$_v8';
    noteController.text = _v9;

    diseaseController.addListener(() => setState(() {}));
    getMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: Text('Edit Record of P' + '$_v2'),
        backgroundColor: Colors.indigo[400],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
        children: [
          Text('Medicine ID'),
          buildMedicineId(),
          const SizedBox(
            height: 16,
          ),
          Text('Disease'),
          buildDisease(),
          const SizedBox(
            height: 16,
          ),
          Text('Start medicine intake Date'),
          buildStartDate(),
          const SizedBox(
            height: 16,
          ),
          Text('End medicine intake Date'),
          buildEndDate(),
          const SizedBox(
            height: 16,
          ),
          Text('Amount of medicine'),
          buildAmount(),
          const SizedBox(
            height: 16,
          ),
          Text('Note (optional)'),
          buildNote(),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                if (medList == null ||
                    diseaseController.text.isEmpty ||
                    startDateController.text.isEmpty ||
                    endDateController.text.isEmpty ||
                    amountController.text.isEmpty) {
                  setState(() {
                    result = 'Please input all information!';
                  });
                } else {
                  DateTime timeStart = DateTime.parse(startDateController.text);
                  DateTime timeEnd = DateTime.parse(endDateController.text);
                  if (timeStart.isAfter(timeEnd)) {
                    setState(() {
                      result =
                          'End medicine intake date must be after Start date!';
                    });
                  } else {
                    updateRecord();
                    setState(() {
                      // Infact, we want user to be able to continuously edit record
                      result =
                          'Data is saved, record has been updated successfully!';
                      success = true;
                      Navigator.pop(context, jsondata);
                    });
                  }
                }
                final snackBar = SnackBar(
                    content: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor:
                        success == false ? Colors.red[900] : Colors.green[900]);
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                success = false;
              },
              child: const Text(
                'Edit a record',
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
        ],
      ),
    );
  }

  /* build a medicineId input field */
  Widget buildMedicineId() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(48, 2, 12, 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white,
            ),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            hint: Text('Medicine ID'),
            value: medId,
            isExpanded: true,
            items: medList.map(buildMedicine).toList(),
            onChanged: (String? value) => setState(() => medId = value!),
            // onChanged: (medId) => setState(() => this.medId = medId),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 14.0, left: 12.0),
          child: Icon(
            Icons.medication,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  /* build a dropdown menu for choosing which medicine to assigns to patient */
  DropdownMenuItem<String> buildMedicine(String medicine) {
    return DropdownMenuItem(
      value: medicine,
      child: Text(
        medicine,
      ),
    );
  }

  /* build a disease input field */
  Widget buildDisease() {
    return TextField(
      controller: diseaseController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.medical_information),
        suffixIcon: diseaseController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => diseaseController.clear(),
              ),
      ),
      textInputAction: TextInputAction.done,
    );
  }

  /* build a date-to-start medication input field */
  Widget buildStartDate() {
    return TextField(
        controller: startDateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.calendar_month),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime(
                  1900), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));
          if (pickedDate != null) {
            print(
                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(
                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
            print(
                formattedDate); //formatted date output using intl package =>  2022-07-04
            //You can format date as per your need

            setState(() {
              startDateController.text =
                  formattedDate; //set formatted date to TextField value.
            });
          } else {
            print("Date is not selected");
          }
        });
  }

  /* build a date-to-end medication input field */
  Widget buildEndDate() {
    return TextField(
        controller: endDateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.calendar_month),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(), //get today's date
            firstDate: DateTime(
                1900), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            print(
                pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(
                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
            print(
                formattedDate); //formatted date output using intl package =>  2022-07-04
            //You can format date as per your need

            setState(() {
              endDateController.text =
                  formattedDate; //set foratted date to TextField value.
            });
          } else {
            print("Date is not selected");
          }
        });
  }

  /* build a amount of medicine-to-take-per-meal input field */
  Widget buildAmount() {
    return TextField(
      controller: amountController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      keyboardType: TextInputType.number,
    );
  }

  /* build a note input field */
  Widget buildNote() {
    return TextFormField(
      controller: noteController,
      minLines: 3,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  /* get the medicine from the database to put in the record field */
  Future<void> getMedicine() async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/all-medicine');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      rawmed = jsonDecode(result);
      if (rawmed.length > 0) {
        medList = [];
        for (int i = 0; i < rawmed.length; ++i) {
          medList.add(
              "M" + "${rawmed[i]['id']}" + ": " + rawmed[i]['Medicine_name']);
        }
      }
    });
  }

  /* update a record and submit it to the database */
  Future<void> updateRecord() async {
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/update-record/$_v1');
    Map<String, String> header = {"Content-type": "application/json"};

    String temp_string_mid = '';
    int temp_int_mid = 0;
    if (medId != null) {
      temp_string_mid = medId!;
      int i = 1;
      while (temp_string_mid[i] != ':') {
        ++i;
      }
      temp_string_mid = temp_string_mid.substring(1, i);
      temp_int_mid = int.parse(temp_string_mid);
    }

    String v1 = '"patient":$_v2';
    String v2 = '"medicine":$temp_int_mid';
    String v3 = '"Record_disease":"${diseaseController.text}"';
    String v4 = '"Record_amount":${amountController.text}';
    String v5 = '"Record_start":"${startDateController.text}"';
    String v6 = '"Record_end":"${endDateController.text}"';
    String v7 = '"Record_info":"${noteController.text}"';
    String v8 = '"Record_isComplete":"false"';
    jsondata = '{$v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8}';
    //print(jsondata);

    var response = await http.put(url,
        headers: header,
        body: jsondata); // Note: รอจบแล้วที่ await แล้ว แต่มันปรินต์ช้าเฉยๆครับ
    var uft8result = utf8.decode(response.bodyBytes);
    print('UPDATE RECORD!');
    print(uft8result);
  }
}
