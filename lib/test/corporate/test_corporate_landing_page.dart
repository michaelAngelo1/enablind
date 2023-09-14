import 'package:flutter/material.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/test/auth/test_login_page.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_applicants/test_corporate_applicants_list.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_past_jobs.dart';
import 'test_corporate_landing_page_tabs/test_corporate_active_jobs/test_corporate_active_jobs.dart';

class CorporateLandingPage extends StatelessWidget {
  const CorporateLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab Bar Example'),
          actions: [
            IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active Jobs'),
              Tab(text: 'Applicants'),
              Tab(text: 'Past Jobs'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CorporateJobListPage(),
            CorporateJobApplications(),
            PastJobsPage(),
          ],
        ),
      ),
    );
  }
}
