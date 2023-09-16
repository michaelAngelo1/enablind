import 'package:flutter/material.dart';
import 'package:login_app/pages/corporate/active_jobs.dart';
import 'package:login_app/pages/corporate/archivedJobs_page.dart';
import 'package:login_app/pages/corporate/gabung/dashboard/fix_activeJobs.dart';
import 'package:login_app/pages/corporate/gabung/dashboard/fix_applicationTab.dart';
import 'package:login_app/pages/corporate/gabung/dashboard/fix_archivedJobs.dart';
import 'package:login_app/pages/corporate/jobApplications_page.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_active_jobs/test_corporate_active_jobs.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_applicants/test_corporate_applicants_list.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_past_jobs.dart';
import 'package:login_app/variables.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  bool _checkSelected(int idx) {
    if (_currentIndex == idx)
      return true;
    else
      return false;
  }

  final List<Widget> _pages = [
    // CorpActiveJobs(),
    // CorporateJobListPage(),
    CorpActiveJobs(),
    CorpApplicationsTab(),
    ArchivedJobsTab(),
    // CorpApplicationsTab(),
    // ArchivedJobsTab(),
    // CorporateJobListPage(),
    // CorporateJobApplications(),
    // PastJobsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 74, 74, 75),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          padding: EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                    print('current index : $_currentIndex');
                  },
                  style: ButtonStyle(
                    backgroundColor: _checkSelected(0)
                        ? MaterialStateProperty.all<Color>(accentColor)
                        : MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 74, 74, 75)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded edges
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Active Jobs",
                      style: TextStyle(
                          color:
                              _checkSelected(0) ? Colors.black : Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                    print('current index : $_currentIndex');
                  },
                  style: ButtonStyle(
                    backgroundColor: _checkSelected(1)
                        ? MaterialStateProperty.all<Color>(accentColor)
                        : MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 74, 74, 75)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded edges
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Applicants",
                      style: TextStyle(
                          color:
                              _checkSelected(1) ? Colors.black : Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                    print('current index : $_currentIndex');
                  },
                  style: ButtonStyle(
                    backgroundColor: _checkSelected(2)
                        ? MaterialStateProperty.all<Color>(accentColor)
                        : MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 74, 74, 75)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded edges
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Archived",
                      style: TextStyle(
                          color:
                              _checkSelected(2) ? Colors.black : Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 24),
        _pages[_currentIndex],
      ],
    );
  }
}
