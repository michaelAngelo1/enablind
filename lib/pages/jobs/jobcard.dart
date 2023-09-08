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
      height: 150,
      width: 500,
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
                  width: 40,
                  height: 40,
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
                        Text(
                          "Altasian",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: titleContentColor,
                          )
                        ),

                        // Save Job List
                        Container(
                          margin: const EdgeInsets.only(left: 140.0),
                          width: 2,
                          child: Icon(
                            Icons.bookmark_border_outlined,
                            color: titleContentColor,
                          ),
                        )
                      ],
                    ),

                    // Role Text
                    Row(
                      children: [
                        Text(
                          "Product Designer",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: titleContentColor,
                          )
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
            const SizedBox(height: 8.0),
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
                    fontSize: 12.0,
                    color: titleContentColor,
                  )
                )
              ]
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    "Freelance",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: accentColor
                    )
                  )
                ),
                const SizedBox(width: 5),
                Container(
                  height: 26,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    "Full-time",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
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
