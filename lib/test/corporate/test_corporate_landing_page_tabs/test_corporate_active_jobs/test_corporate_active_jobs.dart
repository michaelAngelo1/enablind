import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'test_corporate_job_details.dart';

class CorporateJobListPage extends StatefulWidget {
  const CorporateJobListPage({super.key});

  @override
  State<CorporateJobListPage> createState() => _CorporateJobListPageState();
}

class _CorporateJobListPageState extends State<CorporateJobListPage> {
  Future<List<Map<String, dynamic>>> _fetchCorporateDataForJobListings(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> jobListings) async {
    final List<Future<DocumentSnapshot<Map<String, dynamic>>>> corporateDataFutures = [];

    for (final jobListing in jobListings) {
      final companyUid = jobListing['jobCompany'];
      corporateDataFutures.add(FirebaseFirestore.instance.collection('Users/Role/Corporations').doc(companyUid).get());
    }

    final corporateDataSnapshots = await Future.wait(corporateDataFutures);

    return corporateDataSnapshots.map((snapshot) => snapshot.data() as Map<String, dynamic>).toList();
  }

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

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchCorporateDataForJobListings(jobListings),
          builder: (context, corporateDataSnapshot) {
            if (corporateDataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (corporateDataSnapshot.hasError) {
              return const Center(
                child: Text('Error loading corporate data.'),
              );
            }

            if (!corporateDataSnapshot.hasData || corporateDataSnapshot.data!.isEmpty) {
              return const Center(
                child: Text('No corporate data available.'),
              );
            }

            final corporateDataList = corporateDataSnapshot.data!;
            final jobListWidgets = <Widget>[];

            for (var i = 0; i < jobListings.length; i++) {
              final jobListing = jobListings[i].data() as Map<String, dynamic>;
              final companyData = corporateDataList[i];

              final companyName = companyData['corporationName'];
              final companyLogo = companyData['logoUrl'];

              jobListWidgets.add(
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailsPage(jobListing: jobListing),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(jobListing['jobTitle'] ?? ''),
                    subtitle: Text(jobListing['jobType'] ?? ''),
                    leading: Image.network(companyLogo), // Display company logo
                    trailing: Text('Posted by: $companyName'), // Display company name
                  ),
                ),
              );
            }

            return ListView(
              children: jobListWidgets,
            );
          },
        );
      },
    );
  }
}
