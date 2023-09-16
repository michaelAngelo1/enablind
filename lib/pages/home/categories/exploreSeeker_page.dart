import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
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
              Row(
                children: [
                  Text("Popular Jobs",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: titleContentColor,
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                        width: 20,
                      )),
                  Text("See all",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffb404040),
                      ))
                ],
              ),

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
                                final jobData =
                                    document.data();

                                final job = Joblisting(
                                  jobTitle: jobData['jobTitle'],
                                  jobDescription: jobData['jobDescription'],
                                  jobQualifications:
                                      jobData['jobQualifications'],
                                  jobType: jobData['jobType'],
                                  jobSalary: jobData['jobSalary'],
                                  jobListingCloseDate:
                                      jobData['jobListingCloseDate'],
                                  isBookmarked: jobData['isBookmarked'],
                                  corpName: corpData['corporationName'],
                                  corpLogo: corpData['logoUrl'],
                                );

                                return Column(
                                  children: [
                                    JobCardComponent(
                                      job: job,
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
