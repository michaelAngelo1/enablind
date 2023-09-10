import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/pages/jobs/jobcard.dart';
import 'package:login_app/variables.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: mainBgColor,
        elevation: 0,
      ),
      body: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: mainBgColor,
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
                          fontSize: 18,
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
                          fontSize: 16.0,
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
      bottomNavigationBar:  NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: bottomNavBarColor,
        indicatorColor: bottomNavBarColor,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          // Explore Jobs
          NavigationDestination(
            selectedIcon: Icon(
              Icons.work,
              color: accentColor
            ),
            icon: Icon(
              Icons.work_outline,
              color: disabledNavbar
            ),
            label: 'Explore'
          ),

          // Notifs
          NavigationDestination(
            selectedIcon: Icon(
              Icons.notifications,
              color: accentColor
            ),
            icon: Icon(
              Icons.notifications_outlined,
              color: disabledNavbar
            ),
            label: 'Update'
          ),

          // Saved Jobs
          NavigationDestination(
            selectedIcon: Icon(
              Icons.bookmark,
              color: accentColor
            ),
            icon: Icon(Icons.bookmark_border,
              color: disabledNavbar
            ),
            label: 'Saved',
  
          ),

          // Profile
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: accentColor
            ),
            icon: Icon(
              Icons.person_outline,
              color: disabledNavbar
            ),
            label: 'Profile'
          ),
        ]
      ),
    );
  }
}
