import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/test/auth/test_login_page.dart';
import 'test_corporate_job_details.dart';

class CorporateJobListPage extends StatefulWidget {
  const CorporateJobListPage({super.key});

  @override
  State<CorporateJobListPage> createState() => _CorporateJobListPageState();
}

class _CorporateJobListPageState extends State<CorporateJobListPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Jobs').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final jobListings = snapshot.data!.docs;

        if (jobListings.isEmpty) {
          return const Center(
            child: Text('No job listings available.'),
          );
        }

        return ListView.builder(
          itemCount: jobListings.length,
          itemBuilder: (context, index) {
            final jobListing = jobListings[index].data() as Map<String, dynamic>;
            final companyUid = jobListing['jobCompany'];

            return InkWell(
              onTap: () {
                // Navigate to a new page when ListTile is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobDetailsPage(jobListing: jobListing),
                  ),
                );
              },
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('Users/Role/Corporations').doc(companyUid).get(),
                builder: (context, companySnapshot) {
                  if (companySnapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      title: Text(jobListing['jobTitle'] ?? ''),
                      subtitle: Text(jobListing['jobType'] ?? ''),
                      // You can add more details from the job listing here
                      trailing: const CircularProgressIndicator(), // Loading indicator while fetching company data
                    );
                  }

                  if (companySnapshot.hasError) {
                    return ListTile(
                      title: Text(jobListing['jobTitle'] ?? ''),
                      subtitle: Text(jobListing['jobType'] ?? ''),
                      // You can add more details from the job listing here
                      trailing: const Icon(Icons.error), // Show an error icon
                    );
                  }

                  if (!companySnapshot.hasData) {
                    return ListTile(
                      title: Text(jobListing['jobTitle'] ?? ''),
                      subtitle: Text(jobListing['jobType'] ?? ''),
                      // You can add more details from the job listing here
                      trailing: const Text('Company data not available'), // Show a message if no data is found
                    );
                  }

                  final companyData = companySnapshot.data!.data() as Map<String, dynamic>;

                  // Here, you can access the company name and logo from companyData
                  final companyName = companyData['corporationName'];
                  final companyLogo = companyData['logoUrl'];

                  return ListTile(
                    title: Text(jobListing['jobTitle'] ?? ''),
                    subtitle: Text(jobListing['jobType'] ?? ''),
                    // You can add more details from the job listing here
                    leading: Image.network(companyLogo), // Display company logo
                    trailing: Text('Posted by: $companyName'), // Display company name
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
