import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/variables.dart';

class ExploreSeeker extends StatelessWidget {
  const ExploreSeeker({
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