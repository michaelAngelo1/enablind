import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/bottomButton.dart';
import 'package:login_app/models/applicant.dart';
import 'package:login_app/pages/CV/cv_viewer_page.dart';
import 'package:login_app/pages/aboutEnablind_page.dart';
import 'package:login_app/variables.dart';

class ApplicantDetail extends StatefulWidget {
  final Applicant applicant;
  const ApplicantDetail({super.key, required this.applicant});

  @override
  State<ApplicantDetail> createState() => _ApplicantDetailState();
}

class _ApplicantDetailState extends State<ApplicantDetail> {
  bool _checkSelected(int idx) {
    //ignore
    if (0 == idx)
      return true;
    else
      return false;
  }

  void _handleButtonPress() {
    print('update applicant pressed');
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTemplate(
      title: widget.applicant.role,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(widget.applicant.fullName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffbf7f8f9),
                      )),
                ),
                const SizedBox(height: 8.0),

                Center(
                  child: Text(widget.applicant.phoneNum,
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
                            print('cover letter clicked');
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
                              "Cover Letter",
                              style: TextStyle(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CVViewer()),
                            );
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
                              "CV",
                              style: TextStyle(
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
                          onPressed: () {},
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
                              "Profile",
                              style: TextStyle(
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cover Letter',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'widget.applicant.coverLetter',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BottomButton(
            label: 'Update Applicant',
            onPressed: _handleButtonPress,
          ),
        ],
      ),
    );
  }
}
