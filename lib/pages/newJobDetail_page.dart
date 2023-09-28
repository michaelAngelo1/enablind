import 'dart:math';

import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/bottomButton.dart';
import 'package:login_app/models/joblisting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_apply/test_cv_maker.dart';
import 'package:login_app/variables.dart';
import 'package:intl/intl.dart';

class NewJobDetailPage extends StatefulWidget {
  final Map<String, dynamic> job;
  final String corpName;
  final bool isClosed;
  final bool isJobseeker;
  const NewJobDetailPage({
    required this.job,
    required this.corpName,
    required this.isClosed,
    required this.isJobseeker,
  });

  State<NewJobDetailPage> createState() => _NewJobDetailPageState();
}

class _NewJobDetailPageState extends State<NewJobDetailPage>
    with TickerProviderStateMixin {
  bool saved = false;
  int _currentIndex = 0;

  bool _checkSelected(int idx) {
    if (_currentIndex == idx)
      return true;
    else
      return false;
  }

  void _handleButtonPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CvTemplate(
          jobListing: widget.job,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTemplate(
      title: 'Job Details',
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              saved = !saved;
            });
          },
          icon: saved
              ? const Icon(
                  Icons.bookmark,
                  semanticLabel: 'click to remove saved job',
                )
              : const Icon(
                  Icons.bookmark_outline,
                  semanticLabel: 'click to save job',
                ),
        ),
      ],
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                Center(
                  child: Text(widget.job['jobTitle'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbf7f8f9),
                      )),
                ),
                const SizedBox(height: 8.0),

                Center(
                  child: Text(widget.corpName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffbf7f8f9),
                      )),
                ),

                const SizedBox(height: 20),

                const Divider(color: Color.fromARGB(255, 218, 213, 213)),

                const SizedBox(height: 24),

                // ButtonGroup
                Container(
                  decoration: const BoxDecoration(
                    color: buttonGroupColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                            print('current index : $_currentIndex');
                          },
                          style: ButtonStyle(
                            backgroundColor: _checkSelected(0)
                                ? MaterialStateProperty.all<Color>(accentColor)
                                : MaterialStateProperty.all<Color>(
                                    buttonGroupColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // Rounded edges
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Descriptions",
                              style: GoogleFonts.plusJakartaSans(
                                  color: _checkSelected(0)
                                      ? Colors.black
                                      : Colors.grey.withOpacity(0.5),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 1),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                            print('current index : $_currentIndex');
                          },
                          style: ButtonStyle(
                            backgroundColor: _checkSelected(1)
                                ? MaterialStateProperty.all<Color>(accentColor)
                                : MaterialStateProperty.all<Color>(
                                    buttonGroupColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // Rounded edges
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Qualifications",
                              style: GoogleFonts.plusJakartaSans(
                                  color: _checkSelected(1)
                                      ? Colors.black
                                      : Colors.grey.withOpacity(0.5),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                            print('current index : $_currentIndex');
                          },
                          style: ButtonStyle(
                            backgroundColor: _checkSelected(2)
                                ? MaterialStateProperty.all<Color>(accentColor)
                                : MaterialStateProperty.all<Color>(
                                    buttonGroupColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8.0), // Rounded edges
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Other info",
                              style: GoogleFonts.plusJakartaSans(
                                  color: _checkSelected(2)
                                      ? Colors.black
                                      : Colors.grey.withOpacity(0.5),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 24),

                <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Job Description',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.job['jobDescription'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Qualification',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      for (int index = 0;
                          index < widget.job['jobQualifications'].length;
                          index++)
                        Text(
                          '     ${index + 1}.   ${widget.job['jobQualifications'][index].toString()}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Other info',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Job salary: ${widget.job['jobSalary']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        'Job type: ${widget.job['jobType']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        'Job publish date: ${DateFormat('dd-MM-yyyy').format(widget.job['jobListingPublishDate'].toDate())}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        'Job close date: ${widget.job['jobListingCloseDate'] != null ? DateFormat('dd-MM-yyyy').format(widget.job['jobListingCloseDate']!.toDate()) : '-'}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ][_currentIndex],
              ],
            ),
          ),
          if (widget.isJobseeker)
            BottomButton(
              label: 'Apply Now',
              onPressed: _handleButtonPress,
            ),
        ],
      ),
    );
  }
}
