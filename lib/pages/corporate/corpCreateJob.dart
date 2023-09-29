import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/bottomButton.dart';
import 'package:login_app/components/createJobFormField.dart';
import 'package:login_app/variables.dart';

class CorpCreateJob extends StatefulWidget {
  const CorpCreateJob({super.key});

  @override
  CorpCreateJobState createState() => CorpCreateJobState();
}

class CorpCreateJobState extends State<CorpCreateJob> {
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
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['Full-time', 'Part-time', 'Contract'];

    return BackgroundTemplate(
      title: 'Create Job',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateJobFormField(
                  title: 'Job Title',
                  hintText: 'Job title/job posisition',
                  semanticCounterText: 'Please enter job title/job posisition',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a job title/job posisition';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    jobTitle = value!;
                  },
                ),
                CreateJobFormField(
                  title: 'Job Description',
                  hintText: 'Job Description',
                  semanticCounterText: 'Please enter job description',
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
                CreateJobFormField(
                  title: 'Job Qualifications (comma-separated)',
                  hintText:
                      'Write job qualifications points with comma-separated',
                  semanticCounterText: 'Please enter job qualifications',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a job qualifications';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    jobQualifications = value!.split(',');
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownMenu<String>(
                    onSelected: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        jobType = value!;
                      });
                    },
                    dropdownMenuEntries:
                        list.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                CreateJobFormField(
                  title: 'Job Salary',
                  hintText: 'Enter job salary',
                  semanticCounterText: 'Please enter job salary',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vacancy Close Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 74, 74, 75),
                            borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                jobListingCloseDate != null
                                    ? '${DateFormat('MMM dd, yyyy').format(jobListingCloseDate!.toLocal())}'
                                    : 'Not set',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: accentColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 36),
                BottomButton(
                  label: 'Create Job',
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
