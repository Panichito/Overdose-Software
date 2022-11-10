import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  String result='note field can be empty';
  String? patientId;
  bool success = false;
  // final patientIdController = TextEditingController();
  final medicineIdController = TextEditingController();
  final diseaseController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  // temp list of patient for demonstration
  final patientList = ['P001', 'P002', 'P003', 'P004', 'P005', 'P006'];

  @override
  void initState() {
    super.initState();
    
    // patientIdController.addListener(() => setState(() {}));
    medicineIdController.addListener(() => setState(() {}));
    diseaseController.addListener(() => setState(() {}));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
        children: [
          buildPatientId(),
          const SizedBox(height: 16,),
          buildMedicineId(),
          const SizedBox(height: 16,),
          buildDisease(),
          const SizedBox(height: 16,),
          buildStartDate(),
          const SizedBox(height: 16,),
          buildEndDate(),
          const SizedBox(height: 16,),
          buildAmount(),
          const SizedBox(height: 16,),
          buildNote(),
          const SizedBox(height: 16,),
          ElevatedButton(onPressed: () {

            if(patientId == null || medicineIdController.text.isEmpty || diseaseController.text.isEmpty ||
                startDateController.text.isEmpty || endDateController.text.isEmpty || amountController.text.isEmpty) {
              setState(() {
                result='Please input all information';
              });
            }
            else {
              DateTime timeStart = DateTime.parse(startDateController.text);
              DateTime timeEnd = DateTime.parse(endDateController.text);
              if(timeStart.isAfter(timeEnd)) {
                setState(() {
                  result='End medicine intake date must be after Start date';
                });
              }
              else {
                // createRecordFunction();
                setState(() {
                  result='Create a record successfully';
                  success = true;
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
                backgroundColor: !success?
                  Colors.red[900]:
                  Colors.green[900]
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            success = false;
          },
          child: const Text(
            'Create a record',
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
            border: Border.all(color: Colors.grey,),
          ),
          child: DropdownButton<String>(
            // controller: patientIdController,
            hint: Text('Patient ID'),
            value: patientId,
            isExpanded: true,
            items: patientList.map(buildPatient).toList(),
            onChanged: (patientId) =>
                setState(() => this.patientId = patientId),
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
    return TextField(
      controller: medicineIdController,
      decoration: InputDecoration(
        hintText: 'M001',
        labelText: 'Medicine ID',
        prefixIcon: Icon(Icons.medication),
        suffixIcon: medicineIdController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
          icon: Icon(Icons.close),
          onPressed: () => medicineIdController.clear(),
        ),
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
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
          firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101)
        );
        if(pickedDate!=null ){
          print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
          String formattedDate=DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
          print(formattedDate); //formatted date output using intl package =>  2022-07-04
          //You can format date as per your need

          setState(() {
            startDateController.text=formattedDate; //set foratted date to TextField value.
          });
        }
        else{
          print("Date is not selected");
        }
      }
    );
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
          firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101),
        );
        if(pickedDate!=null ){
          print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
          String formattedDate=DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
          print(formattedDate); //formatted date output using intl package =>  2022-07-04
          //You can format date as per your need

          setState(() {
            endDateController.text=formattedDate; //set foratted date to TextField value.
          });
        }
        else{
          print("Date is not selected");
        }
      }
    );
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
}
