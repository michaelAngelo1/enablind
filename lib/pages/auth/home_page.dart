import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/pages/jobs/jobcard.dart';
import 'package:login_app/variables.dart';
import 'select_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SelectPage()), // Replace with your JobseekerPage
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffb0f0c07),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hi, ${user.email!}",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: titleContentColor
                    )
                  ),
                  const SizedBox(height: 30.0),

                  // Title JobList
                  Row(
                    children: [
                      Text(
                        "Popular Jobs",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: titleContentColor,
                        )
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.transparent,
                          width: 20,
                        )
                      ),
                      Text(
                        "See all",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffb404040),
                        )
                      )
                    ],
                  ),

                  const SizedBox(height: 14.0),

                  // Category Job 2x4
                  

                  // Card Job List
                  JobCard()


                ]
              )
            )
          ),

          // Update Page
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.blue
            )
          ),

          // Saved Jobs
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.red
            )
          ),

          // Profile
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.green
            )
          )
        ][currentPageIndex],

      // BottomNavBar: Explore, Notifs, Saved, Profile
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: accentColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[

          // Explore Jobs
          NavigationDestination(
            selectedIcon: Icon(Icons.work),
            icon: Icon(Icons.work_outline),
            label: 'Explore'
          ),

          // Notifs
          NavigationDestination(
            selectedIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
            label: 'Update'
          ),

          // Saved Jobs
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Saved'
          ),

          // Profile
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile'
          ),
        ]
      ),
    );
  }
}

