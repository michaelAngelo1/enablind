import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/componentMaker.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/pages/home/categories/savedSeeker_page.dart';
import 'package:login_app/pages/home/categories/updatesSeeker_page.dart';
import 'package:login_app/test/auth/test_login_page.dart';
import 'package:login_app/variables.dart';

import 'categories/exploreSeeker_page.dart';
import 'categories/profileSeeker_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // page Index
  int currentPageIndex = 0;

  // user object
  final user = auth.currentUser!;

  void signUserOut() {
    auth.signOut();
  }

  List<Joblisting> jobList = [];

  @override
  Widget build(BuildContext context) {
    //data
    

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome! Explore various jobs only on Enablind,',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: titleContentColor),
            ),
            Text(
              user.email!,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: titleContentColor),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            tooltip: 'goto component maker',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComponentTest()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
      body: <Widget>[
        // EDITABLE AREA FOR CONTRIBUTORS

        // exploreSeeker_page
        ExploreSeeker(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            jobList: jobList),

        // Update Page
        UpdatesSeeker(),

        // Saved Jobs
        SavedSeeker(),

        // Profile
        ProfileSeeker(),

        // END EDITABLE AREA
      ][currentPageIndex],

      // BottomNavBar: Explore, Notifs, Saved, Profile
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: navbarIconColor.withOpacity(0.2),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          // Explore Jobs
          NavigationDestination(
            selectedIcon: Icon(
              Icons.work,
              color: accentColor,
            ),
            icon: Icon(
              Icons.work_outline,
              color: navbarIconColor,
            ),
            label: 'Explore',
          ),

          // Notifs
          NavigationDestination(
            selectedIcon: Icon(
              Icons.notifications,
              color: accentColor,
            ),
            icon: Icon(
              Icons.notifications_outlined,
              color: navbarIconColor,
            ),
            label: 'Update',
          ),

          // Saved Jobs
          NavigationDestination(
            selectedIcon: Icon(
              Icons.bookmark,
              color: accentColor,
            ),
            icon: Icon(
              Icons.bookmark_border,
              color: navbarIconColor,
            ),
            label: 'Saved',
          ),

          // Profile
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: accentColor,
            ),
            icon: Icon(
              Icons.person_outline,
              color: navbarIconColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
