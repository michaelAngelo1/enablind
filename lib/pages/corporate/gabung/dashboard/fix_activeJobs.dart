import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/components/newJobCard.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_active_jobs/test_corporate_job_details.dart';

class CorpActiveJobs extends StatefulWidget {
  const CorpActiveJobs({super.key});

  @override
  State<CorpActiveJobs> createState() => _CorpActiveJobsState();
}

class _CorpActiveJobsState extends State<CorpActiveJobs> {
  Future<List<Map<String, dynamic>>> _fetchCorporateDataForJobListings(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> jobListings) async {
    final List<Future<DocumentSnapshot<Map<String, dynamic>>>>
        corporateDataFutures = [];

    for (final jobListing in jobListings) {
      final companyUid = jobListing['jobCompany'];
      corporateDataFutures.add(FirebaseFirestore.instance
          .collection('Users/Role/Corporations')
          .doc(companyUid)
          .get());
    }

    final corporateDataSnapshots = await Future.wait(corporateDataFutures);

    return corporateDataSnapshots
        .map((snapshot) => snapshot.data() as Map<String, dynamic>)
        .toList();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final Timestamp currentTime = Timestamp.now();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Jobs').where('jobCompany', isEqualTo: _currentUser?.uid).snapshots(),
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

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchCorporateDataForJobListings(jobListings),
          builder: (context, corporateDataSnapshot) {
            if (corporateDataSnapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (corporateDataSnapshot.hasError) {
              return const Center(
                child: Text('Error loading corporate data.'),
              );
            }

            if (!corporateDataSnapshot.hasData ||
                corporateDataSnapshot.data!.isEmpty) {
              return const Center(
                child: Text('No corporate data available.'),
              );
            }

            final corporateDataList = corporateDataSnapshot.data!;
            final jobListWidgets = <Widget>[];

            for (var i = 0; i < jobListings.length; i++) {
              final jobListing = jobListings[i].data() as Map<String, dynamic>;
              final companyData = corporateDataList[i];

              final companyName = companyData['corporationName'] ?? '';
              final companyLogo = companyData['logoUrl'] ?? '';

              if (jobListing['jobListingCloseDate'] == null ||
                  jobListing['jobListingCloseDate']
                      .toDate()
                      .isAfter(currentTime.toDate())) {
                jobListWidgets.add(
                  Column(
                    children: [
                      NewJobCard(
                        job: jobListing,
                        companyLogo: companyLogo,
                        companyName: companyName,
                        enableBookmark: false,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              }
            }

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: jobListWidgets,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
