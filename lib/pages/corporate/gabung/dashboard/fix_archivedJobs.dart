import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/components/newJobCard.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_active_jobs/test_corporate_job_details.dart';
import 'package:login_app/variables.dart';

class ArchivedJobsTab extends StatefulWidget {
  const ArchivedJobsTab({super.key});

  @override
  State<ArchivedJobsTab> createState() => _ArchivedJobsTabState();
}

class _ArchivedJobsTabState extends State<ArchivedJobsTab> {
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

  @override
  Widget build(BuildContext context) {
    final Timestamp currentTime = Timestamp.now();
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uidCorporate = user?.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Jobs').where('UidCorporate', isEqualTo: uidCorporate).snapshots(),
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
                child: Text('No job data available.'),
              );
            }

            final corporateDataList = corporateDataSnapshot.data!;
            final jobListWidgets = <Widget>[];

            for (var i = 0; i < jobListings.length; i++) {
              final jobListing = jobListings[i].data() as Map<String, dynamic>;
              final companyData = corporateDataList[i];
              // ON CONFLICTS, ACCEPT INCOMING
              final jobDocID = jobListings[i].id;

              final companyName = companyData['corporationName'] ?? '';
              final companyLogo = companyData['logoUrl'] ??
                  'https://firebasestorage.googleapis.com/v0/b/enablind-db.appspot.com/o/profile-icon-vector.jpg?alt=media&token=cb2412e9-ebab-436f-9cc7-dba272337d40';

              if (jobListing['jobListingCloseDate'] != null &&
                  jobListing['jobListingCloseDate']
                      .toDate()
                      .isBefore(currentTime.toDate())) {
                jobListWidgets.add(
                  Column(
                    children: [
                      NewJobCard(
                        job: jobListing,
                        jobDocID: jobDocID,
                        companyLogo: companyLogo,
                        companyName: companyName,
                        enableBookmark: false,
                        isClosed: true,
                        isBookmarked: false,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                );
              }
            }

            if (jobListWidgets.isEmpty) {
              jobListWidgets.add(
                const Text(
                  "No archived jobs.",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: titleContentColor,
                  ),
                ),
              );
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
