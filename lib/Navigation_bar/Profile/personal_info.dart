import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String genderdropdownValue = "Select";
  String acedemicdropdownValue = "Select";
  DateTime selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Enter Your Name',
                hintText: "Full Name",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Gender :",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: genderdropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      genderdropdownValue = newValue!;
                    });
                  },
                  items: <String>['Select', 'Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Date of Birth',
                hintText: 'yyyy-mm-dd',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              keyboardType: TextInputType.datetime,
              onFieldSubmitted: (value) {
                try {
                  final DateTime? typedDate =
                      DateFormat('yyyy-MM-dd').parseStrict(value);
                  if (typedDate != null && typedDate.isBefore(DateTime.now())) {
                    setState(() {
                      selectedDate = typedDate;
                    });
                  }
                } catch (e) {
                  print("Invalid date format.");
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Enter Your Address',
                hintText: "Address",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Acedemic Qualification:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: acedemicdropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      acedemicdropdownValue = newValue!;
                    });
                  },
                  items: <String>['Select', '10', '+2', 'Bachelor', 'Master']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
