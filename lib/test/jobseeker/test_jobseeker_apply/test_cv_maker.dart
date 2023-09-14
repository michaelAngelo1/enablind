
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CvTemplate extends StatefulWidget {
  final Map<String, dynamic> jobListing;

  const CvTemplate({Key? key, required this.jobListing}) : super(key: key);

  @override
  CvTemplateState createState() => CvTemplateState();
}

class CvTemplateState extends State<CvTemplate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  List<String> previousEducation = [];
  List<String> workExperience = [];

  

  // Method to submit the form data to Firestore
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Access the jobListing from the widget's parameters
      final Map<String, dynamic> jobListing = widget.jobListing;

      try {
        // Get the current user's UID
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          print("user null");
          return;
        }
        String uid = user.uid;

        // Create a Firestore document with the data
        await FirebaseFirestore.instance.collection('JobApplications').add({
          'uidUser': uid,
          'uidCorporate': jobListing['jobCompany'],
          'fullName': _fullNameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'address': _addressController.text,
          'summary': _summaryController.text,
          'education': previousEducation,
          'experience': workExperience,
          'status': 1,
          'timestamp': DateTime.now(), // Add a timestamp
        });

        // Optionally, you can show a success message or navigate to a new page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application submitted successfully!'),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        print('Error submitting form: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CV Maker"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    // You can add more email validation logic here
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Summary',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _summaryController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Summary',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Education',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Education (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    previousEducation = value.split(',');
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Experience',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Experience (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    workExperience = value.split(',');
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
