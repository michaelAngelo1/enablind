import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/bottomButton.dart';
import 'package:login_app/components/customTextfield.dart';
import 'package:login_app/components/buttons/googleButton.dart';
import 'package:login_app/components/jobs/applicantCard.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/components/jobs/updatesCard.dart';
import 'package:login_app/components/my_button.dart';
import 'package:login_app/components/my_textfield.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/models/jobseeker.dart';
import 'package:login_app/variables.dart';
import 'package:login_app/models/joblisting.dart';
// import 'package:login_app/pages/jobseeker/jobDetailSeeker_page.dart';

class ComponentTest extends StatefulWidget {
  ComponentTest({super.key});

  @override
  State<ComponentTest> createState() => _ComponentTestState();
}

class _ComponentTestState extends State<ComponentTest> {
  final fullNameController = TextEditingController();
  final coverLetterController = TextEditingController();
  bool nameValidate = true;
  bool coverValidate = true;

  bool _validate = false;
  void _handleButtonPress() {
    setState(() {
      nameValidate = fullNameController.value.text.isEmpty ? false : true;
      coverValidate = coverLetterController.value.text.isEmpty ? false : true;
      _validate = nameValidate && coverValidate;

      if (_validate)
        print('goto next page'); // PUT FUNCTION HERE
      else
        print('do nothing');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundTemplate(
      title: 'Job Details',
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                customTextfield(
                  controller: fullNameController,
                  title: 'Full name',
                  hintText: 'write your full name',
                  validate: nameValidate,
                ),
                const SizedBox(height: 20),
                customTextfield(
                  controller: coverLetterController,
                  title: 'Cover letter',
                  hintText: 'write your cover letter',
                  validate: coverValidate,
                  isMultiline: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 36),
          BottomButton(
            label: 'Next',
            onPressed: _handleButtonPress,
          ),
        ],
      ),
    );
  }
}
