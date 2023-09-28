import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/components/newJobCard.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/variables.dart';

Future<List<String>> getSavedJobs() async {
  final currUser = auth.currentUser!.uid;
  final snapshot = await fsdb.collection('Users').doc('Role/Jobseekers/$currUser').get();
  
  if(snapshot.exists) {
    print("snapshot SAVEDJOBS exists");
    final data = snapshot.data() as Map<String, dynamic>;
    final savedJobs = data['savedJobs'] as List<dynamic>;
    return savedJobs.map((job) => job.toString()).toList();
  }
  return [];
}

// ignore: must_be_immutable
class ExploreSeeker extends StatefulWidget {
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
  State<ExploreSeeker> createState() => _ExploreSeekerState();
}

class _ExploreSeekerState extends State<ExploreSeeker> {
  // SHOW SAVED JOBS AS WELL
  final bookmarkedJobRef = fsdb.collection('Jobs');

  List<String> savedJobs = [];

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    super.initState();
    // Call getSavedJobs to retrieve the saved jobs when the widget initializes
    getSavedJobs().then((jobs) {
      setState(() {
        savedJobs = jobs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: titleJobCardColor,
      ),
      height: widget.screenHeight,
      width: widget.screenWidth,
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
                    final jobs = snapshot.data!.docs;
                    final filteredJobs = jobs.where((document) {
                      final jobDocID = document.id;
                      return savedJobs.contains(jobDocID);
                    }).toList();
                    return Column(
                      children: [
                        for (var document in jobs)
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

                                // ON CONFLICTS, ACCEPT INCOMING 
                                final jobDocID = document.id;

                                if (corpData == null || jobData == null) {
                                  // Handle null data gracefully
                                  return const SizedBox.shrink();
                                }

                                final companyLogo =
                                    corpData['logoUrl'] as String?;
                                final companyName =
                                    corpData['corporationName'] as String?;

                                if (companyLogo == null ||
                                    companyName == null) {
                                  // Handle null data for logoUrl and corporationName gracefully
                                  return const SizedBox.shrink();
                                }

                                if(filteredJobs.contains(document)) {
                                  print("masuk filtered jobs");
                                  return Column(
                                    children: [
                                      NewJobCard(
                                        job: jobData,
                                        jobDocID: jobDocID,
                                        companyLogo: companyLogo,
                                        companyName: companyName,
                                        isBookmarked: true,
                                      ),
                                      const SizedBox(height: 16.0),
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    NewJobCard(
                                      job: jobData,
                                      jobDocID: jobDocID,
                                      companyLogo: companyLogo,
                                      companyName: companyName,
                                      isBookmarked: false,
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
