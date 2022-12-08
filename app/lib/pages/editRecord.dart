import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditRecordPage extends StatefulWidget {
  //const EditRecordPage({Key? key}) : super(key: key);
  final v1, v2, v3, v4, v5, v6;
  EditRecordPage(this.v1, this.v2, this.v3, this.v4, this.v5, this.v6);

  @override
  State<EditRecordPage> createState() => _EditRecordPageState();
}

class _EditRecordPageState extends State<EditRecordPage> {
  String result = 'Note field can be empty';
  // String? patientId;
  // String? medId;
  bool success = false;

  // initialize value from the existing record
  String patientId = 'P13: gus s';
  String medId = 'M9: Ya Ma';
  final diseaseController = TextEditingController(text: 'Ultra HIV');
  final startDateController = TextEditingController(text: '2022-12-07');
  final endDateController = TextEditingController(text: '2022-12-30');
  final amountController = TextEditingController(text: '3');
  final noteController =
      TextEditingController(text: 'You will definitely die tomorrow.');
  var caretakerid;

  // list of patient
  List rawpatient = [];
  var patientList = <String>[];

  // list of medicine
  List rawmed = [];
  var medList = <String>[];

  @override
  void initState() {
    super.initState();

    diseaseController.addListener(() => setState(() {}));
    getMedicine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 24,
        title: const Text('Edit Record for P'+'xxx'),
        backgroundColor: Colors.indigo[400],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
        children: [
          buildPatientId(),
          const SizedBox(
            height: 16,
          ),
          buildMedicineId(),
          const SizedBox(
            height: 16,
          ),
          buildDisease(),
          const SizedBox(
            height: 16,
          ),
          buildStartDate(),
          const SizedBox(
            height: 16,
          ),
          buildEndDate(),
          const SizedBox(
            height: 16,
          ),
          buildAmount(),
          const SizedBox(
            height: 16,
          ),
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
                      result = 'Data is saved, record has been updated successfully!';
                      success = true;

                      // We want user to be able to continuously edit record
                      // patientId=null;
                      // medId=null;
                      // diseaseController.clear();
                      // startDateController.clear();
                      // endDateController.clear();
                      // amountController.clear();
                      // noteController.clear();
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
                        !success ? Colors.red[900] : Colors.green[900]);
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

  Widget buildPatientId() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(48, 2, 12, 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: DropdownButton<String>(
            // controller: patientIdController,
            hint: Text('Patient ID'),
            value: patientId,
            isExpanded: true,
            items: patientList.map(buildPatient).toList(),
            onChanged: (String? value) => setState(() => patientId = value!),
            // onChanged: (patientId) => setState(() => this.patientId = patientId),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 14.0, left: 12.0),
          child: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildPatient(String patient) {
    return DropdownMenuItem(
      value: patient,
      child: Text(
        patient,
      ),
    );
  }

  Widget buildMedicineId() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(48, 2, 12, 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey,
            ),
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

  DropdownMenuItem<String> buildMedicine(String medicine) {
    return DropdownMenuItem(
      value: medicine,
      child: Text(
        medicine,
      ),
    );
  }

  Widget buildDisease() {
    return TextField(
      controller: diseaseController,
      decoration: InputDecoration(
        labelText: 'Disease',
        prefixIcon: Icon(Icons.medical_information),
        suffixIcon: diseaseController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => diseaseController.clear(),
              ),
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
    );
  }

  Widget buildStartDate() {
    return TextField(
        controller: startDateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.calendar_month),
          labelText: 'Start medicine intake Date',
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

  Widget buildEndDate() {
    return TextField(
        controller: endDateController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.calendar_month),
          labelText: 'End medicine intake Date',
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

  Widget buildAmount() {
    return TextField(
      controller: amountController,
      decoration: InputDecoration(
        labelText: 'Amount of medicine',
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      keyboardType: TextInputType.number,
    );
  }

  Widget buildNote() {
    return TextFormField(
      controller: noteController,
      minLines: 3,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Note (optional)',
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> getCaretakerID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getInt('id');
    var url = Uri.https(
        'weatherreporto.pythonanywhere.com', '/api/ask-caretakerid/$id');
    var response = await http.get(url);
    var result = utf8.decode(response.bodyBytes);
    print('get my careataker id');
    print(result);
    setState(() {
      caretakerid = result;
    });
  }

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

  Future<void> updateRecord() async {
    var url =
        Uri.https('weatherreporto.pythonanywhere.com', '/api/post-record');
    Map<String, String> header = {"Content-type": "application/json"};

    String temp_string_mid = '';
    int temp_int_mid = 0;
    if (medId != null) {
      temp_string_mid = medId;
      int i = 1;
      while (temp_string_mid[i] != ':') {
        ++i;
      }
      temp_string_mid = temp_string_mid.substring(1, i);
      temp_int_mid = int.parse(temp_string_mid);
    }

/*
    String v1='"patient":$temp_int_pid';
    String v2='"medicine":$temp_int_mid';
    String v3='"Record_disease":"${diseaseController.text}"';
    String v4='"Record_amount":${amountController.text}';
    String v5='"Record_start":"${startDateController.text}"';
    String v6='"Record_end":"${endDateController.text}"';
    String v7='"Record_info":"${noteController.text}"';
    String v8='"Record_isComplete":"false"';
    String jsondata = '{$v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8}';
    //print(jsondata);

    var response = await http.post(url, headers: header, body: jsondata);
    var uft8result=utf8.decode(response.bodyBytes);
    print('EDIT RECORD!');
    print(uft8result);
*/
  }
}
