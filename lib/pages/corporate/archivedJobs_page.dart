import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/models/joblisting.dart';

class ArchievedPage extends StatelessWidget {
  const ArchievedPage({super.key});

  @override
  Widget build(BuildContext context) {
    String corpUID = 'BxuRxdKtGcgA1h2glZQJnPVx8u32'; //auth.currentUser!.uid;
    final Timestamp currentTime = Timestamp.now();
    return FutureBuilder(
      future: fsdb
          .collection('/Jobs/')
          .where('jobCompany', isEqualTo: corpUID)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
              child: Text(
            'No data available',
            style: TextStyle(color: Colors.white),
          ));
        } else {
          return Column(
            children: [
              for (var document in snapshot.data!.docs)
                FutureBuilder(
                  future: fsdb
                      .collection('/Users/Role/Corporations/')
                      .doc(document['jobCompany'])
                      .get(),
                  builder: (context, corpSnapshot) {
                    if (corpSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center();
                    } else if (corpSnapshot.hasError) {
                      print(corpSnapshot.error);
                      return Center(
                          child: Text('Error: ${corpSnapshot.error}'));
                    } else if (!corpSnapshot.hasData) {
                      return const Center(
                          child: Text('No corporation data available'));
                    } else {
                      final corpData =
                          corpSnapshot.data!.data() as Map<String, dynamic>;
                      final jobData = document.data() as Map<String, dynamic>;

                      final job = Joblisting(
                        jobTitle: jobData['jobTitle'],
                        jobDescription: jobData['jobDescription'],
                        jobQualifications: jobData['jobQualifications'],
                        jobType: jobData['jobType'],
                        jobSalary: jobData['jobSalary'],
                        jobListingCloseDate: jobData['jobListingCloseDate'],
                        corpName: corpData['corporationName'],
                        corpLogo: corpData['logoUrl'],
                      );

                      if (jobData['jobListingCloseDate'] != null &&
                          jobData['jobListingCloseDate']
                              .toDate()
                              .isBefore(currentTime.toDate())) {
                        return Column(
                          children: [
                            JobCardComponent(
                              job: job,
                              enableBookmark: false,
                              isClosed: true,
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        );
                      } else {
                        // JobListingCloseDate is in the future or null
                        return const SizedBox.shrink();
                      }
                    }
                  },
                ),
            ],
          );
        }
      },
    );
  }
}
