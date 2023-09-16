import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_applicants/test_corporate_job_application_details.dart';

class CorporateJobApplications extends StatefulWidget {
  const CorporateJobApplications({super.key});

  @override
  State<CorporateJobApplications> createState() => _CorporateJobApplicationsState();
}

class _CorporateJobApplicationsState extends State<CorporateJobApplications> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late User? currentCorporation; // Define currentCorporation as a nullable User
  late Future<QuerySnapshot> jobApplicationsFuture; // Future for querying data

  @override
  void initState() {
    super.initState();
    currentCorporation = auth.currentUser; // Initialize currentCorporation here
    jobApplicationsFuture = _loadApplications();
  }

  // Load job applications from Firestore
  Future<QuerySnapshot> _loadApplications() async {
    return await firestore
        .collection('JobApplications')
        .where('uidCorporate', isEqualTo: currentCorporation!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: jobApplicationsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for data, display a loading spinner
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If there's an error, display an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          // If there's no data or data is empty, display a message
          return const Center(
            child: Text('No job applications found.'),
          );
        } else {
          // Data is available, display the list
          final jobApplications = snapshot.data!.docs;
          return ListView.builder(
            itemCount: jobApplications.length,
            itemBuilder: (context, index) {
              final applicationSnapshot = jobApplications[index]; // Get the document snapshot
              final application = applicationSnapshot.data() as Map<String, dynamic>;
              final jobApplicationId = applicationSnapshot.id; // Get the document ID

              return ListTile(
                title: Text(application['fullName']),
                subtitle: Text(application['role']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobApplicationDetailPage(
                        jobApplication: application,
                        jobApplicationId: jobApplicationId, // Pass the document ID to the detail page
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
