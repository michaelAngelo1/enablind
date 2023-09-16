import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:login_app/components/componentMaker.dart';
// import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/pages/auth/welcome_page.dart';
import 'package:login_app/pages/corporate/corpCreateJob.dart';
import 'package:login_app/pages/corporate/dashboard_page.dart';
import 'package:login_app/pages/home/categories/savedSeeker_page.dart';
import 'package:login_app/pages/home/categories/updatesSeeker_page.dart';
import 'package:login_app/test/corporate/test_corporate_create_job_page.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page.dart';
import 'package:login_app/test/corporate/test_corporate_profile_page.dart';
// import 'package:login_app/test/auth/test_login_page.dart';
import 'package:login_app/variables.dart';

class CorpHomePage extends StatefulWidget {
  CorpHomePage({super.key});

  @override
  State<CorpHomePage> createState() => _CorpHomePageState();
}

class _CorpHomePageState extends State<CorpHomePage> {
  // page Index
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(), //CorporateLandingPage()
    const profileCorp_page(),
  ];

  // user object
  final user = auth.currentUser!;

  List<Joblisting> jobList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: navbarIconColor,
            ),
            label: 'Dashboard',
            activeIcon: Icon(
              Icons.home,
              color: accentColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
              color: navbarIconColor,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person,
              color: accentColor,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Create Job page when the button is pressed
          print('masuksini');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CorpCreateJob(),
            ),
          );
        },
        tooltip: "Create Job Listing",
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
