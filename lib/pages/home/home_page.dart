import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/componentMaker.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/pages/home/categories/savedSeeker_page.dart';
import 'package:login_app/pages/home/categories/updatesSeeker_page.dart';
import 'package:login_app/variables.dart';

import 'categories/exploreSeeker_page.dart';

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
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
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
        Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: Colors.green)),

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

class exploreSeeker extends StatelessWidget {
  const exploreSeeker({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.jobList,
  });

  final double screenHeight;
  final double screenWidth;
  final List<Joblisting> jobList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: topbarColor,
      ),
      height: screenHeight,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15.0),

              // Title JobList
              Row(
                children: [
                  Text("Popular Jobs",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: titleContentColor,
                      )),
                  Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                        width: 20,
                      )),
                  Text("See all",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffb404040),
                      ))
                ],
              ),

              const SizedBox(height: 16.0),

              // Card Job List
              for (var job in jobList)
                Column(
                  children: [
                    JobCardComponent(job: job),
                    const SizedBox(height: 16.0),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
