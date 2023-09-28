import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/newJobCard.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/variables.dart';

List<String> bookmarkedJobs = [];
class SavedSeeker extends StatefulWidget {
  const SavedSeeker({super.key});

  @override
  State<SavedSeeker> createState() => _SavedSeekerState();
}

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

class _SavedSeekerState extends State<SavedSeeker> {

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
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: titleJobCardColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: RefreshIndicator(
          onRefresh: _refresh,
          notificationPredicate: (ScrollNotification notification) {
            return notification.depth == 1;
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                FutureBuilder(
                    future: fsdb.collection('/Jobs/').get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty || snapshot.data!.docs.length == 1) {
                        print("GAADA SAVED JOBS");
                        return Center(
                          child: Text(
                            'No data available',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: titleContentColor,
                            )
                          )
                        );
                      } else {
                        final jobs = snapshot.data!.docs;
                        final filteredJobs = jobs.where((document) {
                          final jobDocID = document.id;
                          return savedJobs.contains(jobDocID);
                        }).toList();
                        print("PANJANG SAVED JOBS: ${filteredJobs.length}");
                  
                        if(filteredJobs.length != 0) {
                          print("SAVED JOBS NOT EMPTY");
                          return Column(
                            children: [
                              for (var document in filteredJobs)
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
                  
                                      final companyLogo = corpData['logoUrl'] as String?;
                                      final companyName = corpData['corporationName'] as String?;
                  
                                      if (companyLogo == null || companyName == null) {
                                        // Handle null data for logoUrl and corporationName gracefully
                                        return const SizedBox.shrink();
                                      }
                                    
                  
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
                                  },
                                ),
                            ],
                          );
                        } else {
                          print("SAVED JOBS EMPTY");
                          return Center(
                            child: Text(
                              'No data available',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: titleContentColor,
                              )
                            )
                          );
                        }
                      }
                    },
                  )
              ]
            )
          ),
        )
      )
    );
  }
}