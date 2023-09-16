import 'package:flutter/material.dart';
import 'package:login_app/pages/corporate/active_jobs.dart';
import 'package:login_app/pages/corporate/archivedJobs_page.dart';
import 'package:login_app/pages/corporate/jobApplications_page.dart';
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
    const JobApplicationPage(),
    const ActiveJobs(),
    const ArchievedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: disabledNavbar,
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
                        : MaterialStateProperty.all<Color>(disabledNavbar),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded edges
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Job Applicants",
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
                        : MaterialStateProperty.all<Color>(disabledNavbar),
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
                        : MaterialStateProperty.all<Color>(disabledNavbar),
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
