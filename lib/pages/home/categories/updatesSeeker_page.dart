import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/components/jobs/updatesCard.dart';
import 'package:login_app/variables.dart';

class UpdatesSeeker extends StatefulWidget {
  @override
  State<UpdatesSeeker> createState() => _UpdatesSeekerState();
}

class _UpdatesSeekerState extends State<UpdatesSeeker> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late User? currentUser;
  late Future<QuerySnapshot> jobApplicationsFuture;

  @override
  void initState() {
    super.initState();
    currentUser = auth.currentUser;
    jobApplicationsFuture = _loadApplications();
  }

  Future<QuerySnapshot> _loadApplications() async {
    return await firestore
        .collection('JobApplications')
        .where('uidUser', isEqualTo: currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: titleJobCardColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: FutureBuilder<QuerySnapshot>(
          future: jobApplicationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No job applications found.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else {
              final jobApplications = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < jobApplications.length; i++)
                      Column(
                        children: [
                          UpdatesCard(
                            jobApplication:
                                jobApplications[i].data() as Map<String, dynamic>,
                            jobApplicationId: jobApplications[i].id,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
