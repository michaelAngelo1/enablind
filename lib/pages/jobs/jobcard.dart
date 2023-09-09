import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/variables.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: 400,
      decoration: BoxDecoration(
        color: cardJobListColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            // Card Job List Content
            Row(
              children: [
                // Company Logo
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  )
                ),
                const SizedBox(width: 12.0),

                // Column for Company & Role
                Column(
                  children: [
                    
                    // Company
                    Row(
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            "Altasian",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: titleContentColor,
                            )
                          ),
                        ),

                        // Save Job List
                        Container(
                          margin: const EdgeInsets.only(left: 80.0),
                          width: 2,
                          child: Icon(
                            Icons.bookmark_border_outlined,
                            size: 28,
                            color: titleContentColor,
                          ),
                        )
                      ],
                    ),

                    // Role Text
                    Row(
                      children: [
                        SizedBox(
                          width: 195,
                          child: Text(
                            "Programmer",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: titleContentColor,
                            )
                          ),
                        ),
                        const SizedBox(
                          width: 70,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Location and Type of Work, Mode of Work
            const SizedBox(height: 12.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.location_on_outlined,
                  color: titleContentColor
                ),
                const SizedBox(width: 5),
                Text(
                  "Remote",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                    color: titleContentColor,
                  )
                )
              ]
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    "Freelance",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: accentColor
                    )
                  )
                ),
                const SizedBox(width: 5),
                Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    "Full-time",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: accentColor
                    )
                  )
                ),
              ]
            ),
          ]
        )
      )
    );
  }
}
