import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/variables.dart';

// ignore: must_be_immutable
class ExploreSeeker extends StatelessWidget {
  ExploreSeeker({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.jobList,
  });

  final double screenHeight;
  final double screenWidth;
  late List<Joblisting> jobList;

  @override
  Widget build(BuildContext context) {

    // DUMMY DATA
    if(jobList.isEmpty) {
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
    }
    

    return Container(
      decoration: const BoxDecoration(
        color: titleJobCardColor,
      ),
      height: screenHeight,
      width: screenWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
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