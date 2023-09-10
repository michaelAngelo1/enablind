import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/pages/jobs/jobdetail.dart';
import 'package:login_app/variables.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required Joblisting job,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => JobDetail())
        );
      },
      child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Card Job List Content
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Altasian",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: titleContentColor,
                        )
                      ),
                      // Role Text
                      Text(
                        "Product Designer",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: titleContentColor,
                        )
                      // Company Logo
                      Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          )),
                      const SizedBox(width: 12.0),

                      // Column for Company & Role
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Altasian",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: titleContentColor,
                              )),
                          // Role Text
                          Text("Product Designer",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: titleContentColor,
                              )),
                        ],
                      ),
                      // Save Job List TODO: Change to iconButton
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // margin: const EdgeInsets.only(left: 140.0),
                              child: Icon(
                                Icons.bookmark_border_outlined,
                                color: titleContentColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  // Save Job List TODO: Change to iconButton
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(left: 140.0),
                          child: Icon(
                            Icons.bookmark_border_outlined,
                            color: titleContentColor,
                          ),
                        ),
                      )
                    ],
                  ),

                  // Location and Type of Work, Mode of Work
                  const SizedBox(height: 8.0),
                  Row(children: <Widget>[
                    Icon(Icons.location_on_outlined, color: titleContentColor),
                    const SizedBox(width: 5),
                    Text("Remote",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: titleContentColor,
                        ))
                  ]),
                  const SizedBox(height: 8.0),
                  Wrap(spacing: 5, children: <Widget>[
                    Container(
                        height: 26,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text("Freelance",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: accentColor))),
                    Container(
                        height: 26,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text("Full-time",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: accentColor))),
                  ]),
                ])));
  }
}
