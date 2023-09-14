// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/components/formBox.dart';
import 'package:login_app/test/corporate/test_corporate_bottom_navbar.dart';
import 'package:login_app/variables.dart';

class NewCorporateForm extends StatefulWidget {
  const NewCorporateForm({Key? key}) : super(key: key);

  @override
  NewCorporateFormState createState() => NewCorporateFormState();
}

class NewCorporateFormState extends State<NewCorporateForm> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String corporationName = "";
  String phoneNumber = "";
  DateTime? foundingDate;
  Timestamp? registrationDate;

  final TextEditingController _foundingDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: foundingDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != foundingDate) {
      setState(() {
        foundingDate = picked;
        _foundingDateController.text = "${picked.toLocal()}".split(' ')[0];
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
                labelText: 'Corporation Name',
                semanticText: 'Please enter the corporation name',
                keyboardType: TextInputType.name,
                onSaved: (value) {
                  corporationName = value!;
                },
              ),
              const SizedBox(height: 24),
              FormBox(
                labelText: 'Phone Number',
                semanticText: 'Please enter the phone number',
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _foundingDateController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Founding Date',
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
                  semanticCounterText:
                      'Please input the corporation founding date',
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

      // Store corporate data in Firestore
      final corporationRegistrationData = {
        'corporationName': corporationName,
        'phoneNumber': phoneNumber,
        'foundingDate': foundingDate,
        'registrationDate': registrationDate,
        'userType': 'corporate',
        'hasRegistered': true
      };

      try {
        // Replace 'Corporations' with your Firestore collection name for corporations
        await firestore
            .collection('Users/Role/Corporations')
            .doc(uid)
            .set(corporationRegistrationData);

        // Navigate to the desired screen after data submission
        // For example, you can navigate to the home page
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CorporateNavbar()));
      } catch (e) {
        print('Error submitting data: $e');
        // Handle the error as needed
      }
    }
  }
}
