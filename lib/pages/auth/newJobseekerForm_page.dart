import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/components/formBox.dart';
import 'package:login_app/pages/home/home_page.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_bottom_navbar.dart';
import 'package:login_app/variables.dart';

class NewJobseekerForm extends StatefulWidget {
  const NewJobseekerForm({Key? key}) : super(key: key);

  @override
  NewJobseekerFormState createState() => NewJobseekerFormState();
}

class NewJobseekerFormState extends State<NewJobseekerForm> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String fullName = "";
  String phoneNumber = "";
  DateTime? dateOfBirth;
  String gender = "";
  Timestamp? registrationDate;

  final TextEditingController _dateOfBirthController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
        _dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTemplate(
      title: 'Jobseeker Data Form',
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBox(
                labelText: 'Full Name',
                semanticText: 'Please enter your full name',
                keyboardType: TextInputType.name,
                onSaved: (value) {
                  fullName = value!;
                },
              ),
              const SizedBox(height: 24),
              FormBox(
                labelText: 'Phone Number',
                semanticText: 'Please enter your phone number',
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _dateOfBirthController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(
                      Icons.calendar_today,
                      color: accentColor,
                    ),
                  ),
                  labelStyle: TextStyle(color: Colors.white),
                  semanticCounterText: 'Input your date of birth',
                  fillColor: Color.fromARGB(255, 74, 74, 75),
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 74, 74, 75)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 62, 67, 74)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 4),
              Row(
                children: <Widget>[
                  const Text(
                    'Gender: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Radio<String>(
                    value: 'Male',
                    groupValue: gender,
                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text(
                    'Male',
                    style: TextStyle(color: Colors.white),
                  ),
                  Radio<String>(
                    value: 'Female',
                    groupValue: gender,
                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text(
                    'Female',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              YellowButton(
                label: 'Submit',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Generate the registration date timestamp
      registrationDate = Timestamp.now();

      // get uid
      final user = auth.currentUser;
      final uid = user!.uid;

      print(uid);

      // Store user data in Firestore
      final jobseekerRegistrationData = {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'registrationDate': registrationDate,
        'userType': 'jobseeker',
        'hasRegistered': true
      };

      try {
        await firestore
            .collection('Users/Role/Jobseekers')
            .doc(uid)
            .set(jobseekerRegistrationData);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print('DISINIIIIIIII Error submitting data: $e');
        // Handle the error as needed
      }
    }
  }
}
