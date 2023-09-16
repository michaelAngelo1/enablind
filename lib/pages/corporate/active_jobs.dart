import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/models/joblisting.dart';

class ActiveJobs extends StatefulWidget {
  const ActiveJobs({super.key});

  @override
  State<ActiveJobs> createState() => _ActiveJobsState();
}

class _ActiveJobsState extends State<ActiveJobs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  Future<List<Map<String, dynamic>>> _fetchCorporateDataForJobListings(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> jobListings) async {
    final List<Future<DocumentSnapshot<Map<String, dynamic>>>> corporateDataFutures =
        jobListings.map((jobListing) {
      final companyUid = jobListing['jobCompany'];
      return FirebaseFirestore.instance.collection('Users/Role/Corporations').doc(companyUid).get();
    }).toList();

    final corporateDataSnapshots = await Future.wait(corporateDataFutures);

    return corporateDataSnapshots.map((snapshot) => snapshot.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
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

              final job = Joblisting(
                jobTitle: jobListing['jobTitle'],
                jobDescription: jobListing['jobDescription'],
                jobQualifications: jobListing['jobQualifications'],
                jobType: jobListing['jobType'],
                jobSalary: jobListing['jobSalary'],
                jobListingCloseDate: jobListing['jobListingCloseDate'],
                corpName: companyData['corporationName'],
                corpLogo: companyData['logoUrl'],
              );

              if (jobListing['jobListingCloseDate'] != null) {
                jobListWidgets.add(
                  JobCardComponent(
                    job: job,
                    enableBookmark: false,
                  ),
                );
                  
              }
            }
            return Column(
              children: jobListWidgets,
            );
          },
        );
      },
    );
  }
}
