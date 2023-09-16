import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JobApplicationDetailPage extends StatefulWidget {
  final Map<String, dynamic> jobApplication;
  final String jobApplicationId;

  const JobApplicationDetailPage({Key? key, required this.jobApplication, required this.jobApplicationId}) : super(key: key);

  @override
  State<JobApplicationDetailPage> createState() => _JobApplicationDetailPageState();
}

class _JobApplicationDetailPageState extends State<JobApplicationDetailPage> {

  int status = 1;
  @override
  void initState() {
    super.initState();
    status = widget.jobApplication['status'];
  }
  
  void _updateStatus(int newStatus) async {
  final String applicationId = widget.jobApplicationId; // Assuming you've passed the document ID as a parameter
  await FirebaseFirestore.instance.collection('JobApplications').doc(applicationId).update({
    'status': newStatus,
  });

  setState(() {
    status = newStatus;
  });

  
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Application Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name: ${widget.jobApplication['fullName']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Email: ${widget.jobApplication['email']}'),
            Text('Phone: ${widget.jobApplication['phone']}'),
            Text('Address: ${widget.jobApplication['address']}'),
            const SizedBox(height: 16),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(widget.jobApplication['summary']),
            const SizedBox(height: 16),
            const Text(
              'Education',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (final education in (widget.jobApplication['education'] as List<dynamic>))
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('- $education'),
              ),
            const SizedBox(height: 16),
            const Text(
              'Experience',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (final experience in (widget.jobApplication['experience'] as List<dynamic>))
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('- $experience'),
              ),
            const SizedBox(height: 16),
            Text(
              'Status: ${getStatusText(status)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            if (status != 3 && status != 0) 
              ElevatedButton(
                onPressed: () {
                  _updateStatus(0);
                },
                child: const Text('Reject'),
              ),
            if (status == 1) // Show "Accept for Interview" if status is 1
              ElevatedButton(
                onPressed: () {
                  _updateStatus(2);
                },
                child: const Text('Accept for Interview'),
              ),
            if (status == 2) // Show "Final Accept" if status is 2
              ElevatedButton(
                onPressed: () {
                  _updateStatus(3);
                },
                child: const Text('Final Accept'),
              ),
              
          ],
        ),
      ),
    );
  }
}
