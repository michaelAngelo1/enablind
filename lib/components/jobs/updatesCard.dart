import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/variables.dart';

class UpdatesCard extends StatelessWidget {
  final Joblisting job;
  final bool newUpdate;
  const UpdatesCard({
    super.key,
    required this.job,
    required this.newUpdate,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the destination page
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
                            job.corpLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.corpName,
                            style: GoogleFonts.plusJakartaSans(
                              color: titleJobCardColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            job.jobTitle,
                            style: GoogleFonts.plusJakartaSans(
                                color: titleJobCardColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Text(
                      newUpdate
                          ? 'You got new update'
                          : 'You haven\'t got any updates',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
