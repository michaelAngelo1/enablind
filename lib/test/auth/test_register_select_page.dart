import 'package:flutter/material.dart';
import 'package:login_app/test/auth/test_register_corporate_page.dart';
import 'package:login_app/test/auth/test_register_jobseeker_page.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CorporateDataPage()),
                );
              }, 
              child: const Text("I'm Corporate")
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const JobseekerDataPage()),
                );
              }, 
              child: const Text("I'm A Jobseeker")
            )
          ],
        ),
      )
    );
  }
}