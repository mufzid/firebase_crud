import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final CollectionReference employee =
      FirebaseFirestore.instance.collection('employee');
  String? selectedStates;
  String? gender;
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  TextEditingController employeeName = TextEditingController();
  TextEditingController employeeEmail = TextEditingController();
  TextEditingController employeeJob = TextEditingController();
  TextEditingController employeeAddress = TextEditingController();
  TextEditingController employeeNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    employeeName.text = args['name'];
    employeeEmail.text = args['email'];
    employeeJob.text = args['job'];
    gender = args['sex'];
    employeeAddress.text = args['address'];
    employeeNumber.text = args['number'];
    countryValue = args['country'];
    stateValue = args['state'];
    cityValue = args['city'];
    final docsId = args['id'];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          'Update Employee',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: employeeName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                  label: const Text('Employee Name')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: employeeEmail,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
                label: const Text('Email'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: employeeJob,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                  label: const Text('Designation')),
            ),
            const SizedBox(
              height: 10,
            ),
            // const Text(
            //   'Gender',
            // ),
            ListTile(
              title: const Text('Male'),
              leading: Radio(
                  value: 'male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  }),
            ),
            ListTile(
              title: const Text('Female'),
              leading: Radio(
                  value: 'female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  }),
            ),
            SizedBox(
              child: TextField(
                controller: employeeAddress,
                decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3)),
                    label: const Text('Address')),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: employeeNumber,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3)),
                  label: const Text('Phone Number')),
            ),
            //
            CSCPicker(
              showStates: true,
              showCities: true,
              flagState: CountryFlag.DISABLE,
              dropdownDecoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 236, 235, 235),
              ),

              disabledDropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: const Color.fromARGB(255, 234, 233, 233),
                  border: Border.all(color: Colors.grey, width: 1)),
              // defaultCountry: CscCountry.India,
              countryFilter: const [
                CscCountry.India,
                CscCountry.United_States,
                CscCountry.Canada
              ],
              countrySearchPlaceholder: "Country",
              stateSearchPlaceholder: "State",
              citySearchPlaceholder: "City",
              countryDropdownLabel: "Country",
              stateDropdownLabel: "State",
              cityDropdownLabel: "City",
              selectedItemStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              dropdownHeadingStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              dropdownItemStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),

              dropdownDialogRadius: 10.0,
              searchBarRadius: 10.0,
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (valueState) {
                setState(() {
                  ///store value in state variable
                  stateValue = valueState;
                });
              },
              onCityChanged: (valueCity) {
                setState(() {
                  ///store value in city variable
                  cityValue = valueCity;
                });
              },
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/list');
                  // addEmployee();
                  updateEmployee(docsId);
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red),
                  minimumSize:
                      MaterialStatePropertyAll(Size(double.infinity, 56)),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }

  void updateEmployee(docsId) {
    Map<String, String> data = {
      'name': employeeName.text,
      'email': employeeEmail.text,
      'job': employeeJob.text,
      'sex': gender.toString(),
      'address': employeeAddress.text,
      'number': employeeNumber.text,
      'country': countryValue.toString(),
      'state': stateValue.toString(),
      'city': cityValue.toString(),
    };
    employee.doc(docsId).update(data).then((value) => Navigator.pop(context));
  }
}
