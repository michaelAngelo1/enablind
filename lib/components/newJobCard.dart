import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/pages/jobseeker/jobDetailSeeker_page.dart';
import 'package:login_app/pages/newJobDetail_page.dart';
import 'package:login_app/variables.dart';

class NewJobCard extends StatefulWidget {
  final Map<String, dynamic> job;
  final bool enableBookmark;
  final bool isClosed;
  final String companyName;
  final String companyLogo;
  const NewJobCard({
    super.key,
    required this.job,
    required this.companyName,
    required this.companyLogo,
    this.enableBookmark = true,
    this.isClosed = false,
  });

  @override
  State<NewJobCard> createState() => _NewJobCardState();
}

class _NewJobCardState extends State<NewJobCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewJobDetailPage(
                        job: widget.job,
                        corpName: widget.companyName,
                        isJobseeker: widget.enableBookmark,
                        isClosed: widget.isClosed,
                      )),
            );
          },
          child: Container(
              width: widget.enableBookmark
                  ? screenWidth - 28 - 70
                  : screenWidth - 28,
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: widget.isClosed
                    ? Color.fromARGB(255, 74, 74, 75)
                    : accentColor,
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
                  if (widget.isClosed)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: accentColor,
                        ),
                        child: Text('Vacancy closed'),
                      ),
                    ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            widget.companyLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.companyName,
                            style: GoogleFonts.plusJakartaSans(
                              color: titleJobCardColor,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            widget.job['jobTitle'],
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
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          widget.job['jobType'],
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
        if (widget.enableBookmark)
          Row(
            children: [
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  // to-do handle tap
                  setState(() {
                    isBookmarked = !isBookmarked; // Toggle bookmark state
                  });
                },
                child: Container(
                  width: 65,
                  height: 120,
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
                  child: Icon(
                      isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border_outlined,
                      color: Colors.black,
                      size: 30,
                      semanticLabel: isBookmarked
                          ? 'click to remove saved job'
                          : 'click to save job'),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
