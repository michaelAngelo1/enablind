import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/firebase/db_instance.dart';

class ApplicationsDetail extends StatefulWidget {
  final Map<String, dynamic> jobApplication;
  final String jobApplicationId;

  const ApplicationsDetail(
      {Key? key, required this.jobApplication, required this.jobApplicationId})
      : super(key: key);

  @override
  State<ApplicationsDetail> createState() => _ApplicationsDetailState();
}

class _ApplicationsDetailState extends State<ApplicationsDetail> {
  int status = 1;
  @override
  void initState() {
    super.initState();
    status = widget.jobApplication['status'];
  }

  void _updateStatus(int newStatus) async {
    final String applicationId = widget
        .jobApplicationId; // Assuming you've passed the document ID as a parameter
    await FirebaseFirestore.instance
        .collection('JobApplications')
        .doc(applicationId)
        .update({
      'status': newStatus,
    });

    setState(() {
      status = newStatus;
    });
  }

  bool _checkSelected(int idx) {
    //ignore
    if (0 == idx)
      return true;
    else
      return false;
  }

  void _handleButtonPress() {
    print('update applicant pressed');
  }

  @override
  Widget build(BuildContext context) {
    final int status = widget.jobApplication['status'];

    String getStatusText(int status) {
      switch (status) {
        case 1:
          return 'Pending';
        case 2:
          return 'Accept for Interview';
        case 3:
          return 'Final Accept';
        default:
          return 'Reject';
      }
    }

    return BackgroundTemplate(
      title: 'Job Application Details',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: fsdb
                    .collection('/Users/Role/Jobseekers/')
                    .doc(widget.jobApplication['uidUser'])
                    .get(),
                builder: (context, jobseekerSnapshot) {
                  if (jobseekerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center();
                  } else if (jobseekerSnapshot.hasError) {
                    return Center(
                        child: Text('Error: ${jobseekerSnapshot.error}'));
                  } else if (!jobseekerSnapshot.hasData) {
                    return const Center(
                        child: Text('No applicant data available'));
                  } else {
                    final jobseekerData =
                        jobseekerSnapshot.data!.data() as Map<String, dynamic>;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 72,
                              height: 72,
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/enablind-db.appspot.com/o/profile-icon-vector.jpg?alt=media&token=cb2412e9-ebab-436f-9cc7-dba272337d40',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Center(
                          child: Text(jobseekerData['fullName'] ?? '',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffbf7f8f9),
                              )),
                        ),
                        const SizedBox(height: 8.0),
                        Center(
                          child: Text(
                            widget.jobApplication['email'] ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xffbf7f8f9),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              const Divider(color: Color.fromARGB(255, 218, 213, 213)),
              const SizedBox(height: 24),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone: ${widget.jobApplication['phone']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Address: ${widget.jobApplication['address']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    Text(
                      widget.jobApplication['summary'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Education',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    for (final education in (widget.jobApplication['education']
                        as List<dynamic>))
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          '- $education',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffbf7f8f9),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    const Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    for (final experience in (widget
                        .jobApplication['experience'] as List<dynamic>))
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          '- $experience',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffbf7f8f9),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Status: ${getStatusText(status)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbf7f8f9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (status != 3 && status != 0)
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _updateStatus(0);
                            },
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    if (status == 1)
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _updateStatus(2);
                            },
                            child: const Text(
                              'Accept for Interview',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    if (status == 2) // Show "Final Accept" if status is 2
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _updateStatus(3);
                            },
                            child: const Text(
                              'Final Accept',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
