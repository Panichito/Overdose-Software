import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  String result = 'note field can be empty';
  String? medicineType;
  bool success = false;
  // final patientIdController = TextEditingController();
  final medicineIdController = TextEditingController();
  final medicineNameController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  // temp list of patient for demonstration
  final medicinelist = ['pill', 'capsule', 'liquid', 'big', 'small', 'inject'];

  @override
  void initState() {
    super.initState();

    // patientIdController.addListener(() => setState(() {}));
    medicineIdController.addListener(() => setState(() {}));
    medicineNameController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
        children: [
          buildMedicineType(),
          const SizedBox(
            height: 16,
          ),
          buildMedicineId(),
          const SizedBox(
            height: 16,
          ),
          buildMedicineName(),
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
                if (medicineType == null ||
                    medicineIdController.text.isEmpty ||
                    medicineNameController.text.isEmpty ||
                    amountController.text.isEmpty) {
                  setState(() {
                    result = 'Please input all information';
                  });
                } else {
                  // createRecordFunction();
                  setState(() {
                    result = 'Create a record successfully';
                    success = true;
                  });
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
                'Create a record',
                style: TextStyle(
                  fontSize: 16,
                ),
              )),
        ],
      ),
    );
  }

  Widget buildMedicineType() {
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
            hint: Text('Medicine Type'),
            value: medicineType,
            isExpanded: true,
            items: medicinelist.map(buildMedicine).toList(),
            onChanged: (medicineType) =>
                setState(() => this.medicineType = medicineType),
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

  DropdownMenuItem<String> buildMedicine(String patient) {
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
        prefixIcon: Icon(Icons.numbers),
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

  Widget buildMedicineName() {
    return TextField(
      controller: medicineNameController,
      decoration: InputDecoration(
        labelText: 'Medicine Name',
        prefixIcon: Icon(Icons.medical_information),
        suffixIcon: medicineNameController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => medicineNameController.clear(),
              ),
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
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
