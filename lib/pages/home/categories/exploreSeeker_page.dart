import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/components/newJobCard.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/variables.dart';

// ignore: must_be_immutable
class ExploreSeeker extends StatelessWidget {
  ExploreSeeker({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.jobList,
  });

  final double screenHeight;
  final double screenWidth;
  late List<Joblisting> jobList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: titleJobCardColor,
      ),
      height: screenHeight,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15.0),

              // Title JobList
              Text("Popular Jobs",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: titleContentColor,
                  )),

              const SizedBox(height: 16.0),

              // Card Job List
              FutureBuilder(
                future: fsdb.collection('/Jobs/').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No data available'));
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
                                return Center(
                                    child:
                                        Text('Error: ${corpSnapshot.error}'));
                              } else if (!corpSnapshot.hasData) {
                                return const Center(
                                    child:
                                        Text('No corporation data available'));
                              } else {
                                final corpData = corpSnapshot.data!.data()
                                    as Map<String, dynamic>;
                                final jobData = document.data();

                                // ON CONFLICTS, ACCEPT INCOMING
                                final jobDocID = document.id;

                                if (corpData == null || jobData == null) {
                                  // Handle null data gracefully
                                  return const SizedBox.shrink();
                                }

                                var companyLogo =
                                    corpData['logoUrl'] as String?;
                                var companyName =
                                    corpData['corporationName'] as String?;

                                if (companyLogo == null) {
                                  companyLogo =
                                      'https://firebasestorage.googleapis.com/v0/b/enablind-db.appspot.com/o/profile-icon-vector.jpg?alt=media&token=cb2412e9-ebab-436f-9cc7-dba272337d40';
                                }
                                if (companyLogo == null ||
                                    companyName == null) {
                                  companyName = '';
                                }

                                return Column(
                                  children: [
                                    NewJobCard(
                                      job: jobData,
                                      jobDocID: jobDocID,
                                      companyLogo: companyLogo,
                                      companyName: companyName,
                                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
