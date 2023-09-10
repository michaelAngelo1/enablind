import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/test/corporate/test_corporate_home_page.dart';

class CorporateDataPage extends StatefulWidget {
  const CorporateDataPage({Key? key}) : super(key: key);

  @override
  CorporateDataPageState createState() => CorporateDataPageState();
}

class CorporateDataPageState extends State<CorporateDataPage> {
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

    if (picked != null && picked != foundingDate) {
      setState(() {
        foundingDate = picked;
        _foundingDateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corporate Data Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Corporation Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the corporation name';
                  }
                  return null;
                },
                onSaved: (value) {
                  corporationName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              TextFormField(
                controller: _foundingDateController,
                decoration: InputDecoration(
                  labelText: 'Founding Date',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
                readOnly: true,
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

      // Store corporate data in Firestore
      final corporationRegistrationData = {
        'corporationName': corporationName,
        'phoneNumber': phoneNumber,
        'foundingDate': foundingDate,
        'registrationDate': registrationDate,
        'userType': 'corporate'
      };

      try {
        // Replace 'Corporations' with your Firestore collection name for corporations
        await firestore.collection('Users/Role/Corporations').doc(uid).set(corporationRegistrationData);

        // Navigate to the desired screen after data submission
        // For example, you can navigate to the home page
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CorporateHomePage()));
      } catch (e) {
        print('Error submitting data: $e');
        // Handle the error as needed
      }
    }
  }
}
