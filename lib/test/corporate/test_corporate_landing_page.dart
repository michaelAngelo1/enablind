import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/test/auth/test_login_page.dart';

class CorporateLandingPage extends StatelessWidget {
  const CorporateLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: const CorporateViewJobs(),
    );
  }
}

class CorporateViewJobs extends StatefulWidget {
  const CorporateViewJobs({super.key});

  @override
  State<CorporateViewJobs> createState() => _CorporateViewJobsState();
}

class _CorporateViewJobsState extends State<CorporateViewJobs> {
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
class JobDetailsPage extends StatefulWidget {
  final Map<String, dynamic> jobListing;

  const JobDetailsPage({required this.jobListing, Key? key}) : super(key: key);

  @override
  JobDetailsPageState createState() => JobDetailsPageState();
}

class JobDetailsPageState extends State<JobDetailsPage> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> companyData;

  @override
  void initState() {
    super.initState();
    final companyUid = widget.jobListing['jobCompany'];
    companyData = FirebaseFirestore.instance.collection('Users/Role/Corporations').doc(companyUid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: Padding(
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
            Text('Salary: \Rp${widget.jobListing['jobSalary']}'),
            // Add more job details here
          ],
        ),
      ),
    );
  }
}