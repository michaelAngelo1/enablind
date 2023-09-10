import 'package:flutter/material.dart';
import 'package:login_app/models/joblisting.dart';

class JobDetailSeeker extends StatelessWidget {
  final Joblisting job;
  const JobDetailSeeker({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Center(
        child: Text('Job qualifications: ${job.jobQualifications}'),
      ),
    );
  }
}
