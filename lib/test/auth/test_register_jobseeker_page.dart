import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_home_page.dart';

class JobseekerDataPage extends StatefulWidget {
  const JobseekerDataPage({Key? key}) : super(key: key);

  @override
  JobseekerDataPageState createState() => JobseekerDataPageState();
}

class JobseekerDataPageState extends State<JobseekerDataPage> {
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

    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
        _dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobseeker Data Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (value) {
                  fullName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
                readOnly: true,
              ),
              Row(
                children: <Widget>[
                  const Text('Gender: '),
                  Radio<String>(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender =  value!;
                      });
                    },
                  ),
                  const Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender =  value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
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
        'userType': 'jobseeker'
      };


      try {
        await firestore.collection('Users/Role/Jobseekers').doc(uid).set(jobseekerRegistrationData);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const JobseekerHomePage()));
      } catch (e) {
        print('Error submitting data: $e');
        // Handle the error as needed
      }
    }
  }
}
