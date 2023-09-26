import 'package:flutter/material.dart';
import 'package:login_app/components/jobs/applicantCard.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/models/applicant.dart';

class JobApplicationPage extends StatelessWidget {
  const JobApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    String corpUID = 'BxuRxdKtGcgA1h2glZQJnPVx8u32'; //auth.currentUser!.uid;
    return FutureBuilder(
      future: fsdb
          .collection('/JobApplications/')
          .where('uidCorporate', isEqualTo: corpUID)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
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
                      .collection('/Users/Role/Jobseekers/')
                      .doc(document['uidUser'])
                      .get(),
                  builder: (context, corpSnapshot) {
                    if (corpSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center();
                    } else if (corpSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${corpSnapshot.error}'));
                    } else if (!corpSnapshot.hasData) {
                      return const Center(
                          child: Text('No corporation data available'));
                    } else {
                      final userData =
                          corpSnapshot.data!.data() as Map<String, dynamic>;
                      final applicationData =
                          document.data() as Map<String, dynamic>;

                      final applicant = Applicant(
                        fullName: userData['fullName'],
                        phoneNum: applicationData['phone'],
                        role: applicationData['role'],
                        address: applicationData['address'],
                        summary: applicationData['summary'],
                        status: applicationData['status'],
                        education: applicationData['education'],
                        experience: applicationData['education'],
                        profilePicture: 'userData[profilePic]',
                        timestamp: applicationData['timestamp'],
                      );

                      return Column(
                        children: [
                          // ApplicantCard(applicant: applicant),
                          const SizedBox(height: 16.0),
                        ],
                      );
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
