import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JobDetailsJobseeker extends StatefulWidget {
  final Map<String, dynamic> jobListing;

  const JobDetailsJobseeker({required this.jobListing, Key? key}) : super(key: key);

  @override
  JobDetailsJobseekerState createState() => JobDetailsJobseekerState();
}

class JobDetailsJobseekerState extends State<JobDetailsJobseeker> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> companyData;
  late bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    final companyUid = widget.jobListing['jobCompany'];
    companyData = FirebaseFirestore.instance.collection('Users/Role/Corporations').doc(companyUid).get().then((value) {
      setState(() {
        isLoading = false; // Set loading to false when data is received
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Display spinner while loading
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: companyData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                        // Handle the case where company data is not available
                        return const Text('Company data not available');
                      }
                      final companyData = snapshot.data!.data() as Map<String, dynamic>;
                      final companyLogoUrl = companyData['logoUrl'];
                      final companyName = companyData['companyName'];

                      return Column(
                        children: [
                          Image.network(companyLogoUrl),
                          Text('Company Name: $companyName'),
                        ],
                      );
                    },
                  ),
                  Text('Job Title: ${widget.jobListing['jobTitle']}'),
                  Text('Job Description: ${widget.jobListing['jobDescription']}'),
                  const Text('Qualifications:'),
                  for (final qualification in (widget.jobListing['jobQualifications'] as List<dynamic>))
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text('- $qualification'),
                    ),
                  Text('Job Type: ${widget.jobListing['jobType']}'),
                  Text('Salary: Rp${widget.jobListing['jobSalary']}'),
                  // Add more job details here
                ],
              ),
            ),
    );
  }
}
