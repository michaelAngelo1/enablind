import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/jobs/componentMaker.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/models/joblisting.dart';
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

  List<Joblisting> jobList = [];

  @override
  Widget build(BuildContext context) {
    //data
    jobList.add(
      Joblisting(
        jobTitle: 'Software Developer',
        jobDescription: 'This is a job description.',
        jobQualifications: 'Bachelor\'s degree in Computer Science',
        jobType: 'Part-time',
        jobSalary: 'IDR 4.000.000 - IDR 5.000.000',
        corpLogo:
            'https://firebasestorage.googleapis.com/v0/b/enablind-db.appspot.com/o/ptabc.jpg?alt=media&token=eba597b4-109c-438d-a3f7-322712e27e03',
        corpName: 'ABC Corporation',
        jobListingCloseDate: DateTime(2023, 10, 8),
      ),
    );
    jobList.add(
      Joblisting(
        jobTitle: 'Hardware Developer',
        jobDescription: 'This is a job description.',
        jobQualifications: 'Bachelor\'s degree in Computer Engineering',
        jobType: 'Full-time',
        jobSalary: 'IDR 5.000.000 - IDR 8.000.000',
        corpLogo:
            'https://firebasestorage.googleapis.com/v0/b/enablind-db.appspot.com/o/ptabc.jpg?alt=media&token=eba597b4-109c-438d-a3f7-322712e27e03',
        corpName: 'DEF Corporation',
        jobListingCloseDate: DateTime(2023, 10, 8),
      ),
    );

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
        Container(
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
        ),

        // Update Page
        Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: Colors.blue)),

        // Saved Jobs
        Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: Colors.red)),

        // Profile
        Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: Colors.green)),
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
