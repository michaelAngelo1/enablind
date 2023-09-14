import 'package:flutter/material.dart';
import 'package:login_app/pages/home/home_page.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_landing_page.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_profile_page.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_saved_jobs_page.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_updates_page.dart';

class JobseekerNavbar extends StatefulWidget {
  const JobseekerNavbar({super.key});

  @override
  State<JobseekerNavbar> createState() => _JobseekerNavbarState();
}

class _JobseekerNavbarState extends State<JobseekerNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const JobseekerSavedJobs(),
    const JobseekerUpdates(),
    const JobseekerProfile(),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
