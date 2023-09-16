import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  CreateJobState createState() => CreateJobState();
}

class CreateJobState extends State<CreateJob> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String jobTitle = "";
  String jobDescription = "";
  List<String> jobQualifications = [];
  String jobType = "";
  double jobSalary = 0.0;
  DateTime jobListingPublishDate = DateTime.now();
  DateTime? jobListingCloseDate;

  final firestoreInstance = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  

  void _submitForm() async {
    final user = auth.currentUser;
    final uid = user!.uid;

    if (_formKey.currentState!.validate()) {
      // Extract data from the form
      _formKey.currentState!.save();

      // Save data to Firestore
      final jobData = {
        'jobCompany': uid,
        'jobTitle': jobTitle,
        'jobDescription': jobDescription,
        'jobQualifications': jobQualifications,
        'jobType': jobType,
        'jobSalary': jobSalary,
        'jobListingPublishDate': jobListingPublishDate,
        'jobListingCloseDate': jobListingCloseDate,
      };

      await firestoreInstance.collection('Jobs').add(jobData);

      // Clear the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {

    const List<String> list = <String>['Full-time', 'Part-time', 'Contract'];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
                onSaved: (value) {
                  jobTitle = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job description';
                  }
                  return null;
                },
                onSaved: (value) {
                  jobDescription = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Job Qualifications (comma-separated)'),
                onSaved: (value) {
                  jobQualifications = value!.split(',');
                },
              ),
              const SizedBox(height: 20),
              DropdownMenu<String>(
                
                initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    jobType = value!;
                  });
                },
                dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Job Salary'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a job salary';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  jobSalary = double.parse(value!);
                },
              ),
              ListTile(
                title: const Text('Job Listing Close Date'),
                subtitle: Text(
                    jobListingCloseDate != null ? '${jobListingCloseDate!.toLocal()}' : 'Not set'),
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      jobListingCloseDate = selectedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}