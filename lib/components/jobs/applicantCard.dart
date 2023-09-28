import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/models/applicant.dart';
import 'package:login_app/models/jobseeker.dart';
import 'package:login_app/pages/corporate/applicantDetail_page.dart';
import 'package:login_app/pages/corporate/gabung/dashboard/fix_applicationDetails.dart';
import 'package:login_app/test/corporate/test_corporate_landing_page_tabs/test_corporate_applicants/test_corporate_job_application_details.dart';
import 'package:login_app/variables.dart';

class ApplicantCard extends StatelessWidget {
  final Map<String, dynamic> jobApplication;
  final String jobApplicationId;
  const ApplicantCard({
    super.key,
    required this.jobApplication,
    required this.jobApplicationId,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the destination page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApplicationsDetail(
                  jobApplication: jobApplication,
                  jobApplicationId:
                      jobApplicationId, // Pass the document ID to the detail page
                ),
              ),
            );
          },
          child: Container(
              width: screenWidth - 28,
              height: 120,
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: accentColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black, // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(5, 5), // Offset (horizontal, vertical)
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/enablind-db.appspot.com/o/profile-icon-vector.jpg?alt=media&token=cb2412e9-ebab-436f-9cc7-dba272337d40', // to-do change
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobApplication['fullName'],
                            style: GoogleFonts.plusJakartaSans(
                                color: titleJobCardColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            jobApplication['phone'],
                            style: GoogleFonts.plusJakartaSans(
                              color: titleJobCardColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          jobApplication['role'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}
