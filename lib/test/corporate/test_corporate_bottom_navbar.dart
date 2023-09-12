import 'package:flutter/material.dart';
import 'package:login_app/test/corporate/test_corporate_create_job_page.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page.dart';
import 'package:login_app/test/corporate/test_corporate_profile_page.dart';

class CorporateNavbar extends StatefulWidget {
  const CorporateNavbar({super.key});

  @override
  State<CorporateNavbar> createState() => _CorporateNavbarState();
}

class _CorporateNavbarState extends State<CorporateNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CorporateLandingPage(),
    Container(), // Placeholder for the Create Job button
    const CorporateProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Create Job page when the button is pressed
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateJob(),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: "Create Job Listing",
      )
    );
  }
}
