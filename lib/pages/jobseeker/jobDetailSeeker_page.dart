import 'package:flutter/material.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:login_app/variables.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailSeeker extends StatefulWidget {
  final Joblisting job;
  const JobDetailSeeker({required this.job});

  @override
  State<JobDetailSeeker> createState() => _JobDetailSeekerState();
}

class _JobDetailSeekerState extends State<JobDetailSeeker> {
  bool saved = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Job Details",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: titleContentColor
            )
          )
        ),
        toolbarHeight: 60,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.arrow_back_rounded
            )
          )
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                saved = !saved;
              });
            },
            icon: saved ? const Icon(Icons.bookmark) : const Icon(Icons.bookmark_outline),
          ),
        ],
        backgroundColor: bgColor,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: bgColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 750,
                width: 500,
                decoration: BoxDecoration(
                  color: cardJobListColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),

                  // Job Vacancy Content
                  children: <Widget>[
                    const SizedBox(height: 32),

                    Center(
                      child: Text(
                        widget.job.jobTitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffbf7f8f9),
                        )
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    Center(
                      child: Text(
                        widget.job.corpName,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffbf7f8f9),
                        )
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Divider(color: titleContentColor),

                    const SizedBox(height: 26),

                    // ButtonGroup
                    Container(
                      decoration: const BoxDecoration(
                        color: buttonGroupColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(accentColor)
                            ),
                            child: Center(
                              child: Text(
                                "Descriptions",
                                style: GoogleFonts.plusJakartaSans(
                                  color: disabledNavbar,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                                )
                              )
                            )
                          ),
                    
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(buttonGroupColor)
                            ),
                            child: Center(
                              child: Text(
                                "Qualifications",
                                style: GoogleFonts.plusJakartaSans(
                                  color: disabledNavbar,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                                )
                              )
                            )
                          ),
                    
                          TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(buttonGroupColor)
                            ),
                            child: Center(
                              child: Text(
                                "Other Info",
                                style: GoogleFonts.plusJakartaSans(
                                  color: disabledNavbar,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600
                                )
                              )
                            )
                          ),
                        ],
                      ),
                    )

                    
                  ]
                )
              )
            ]
          ),
        )
      ),
    );
  }
}
