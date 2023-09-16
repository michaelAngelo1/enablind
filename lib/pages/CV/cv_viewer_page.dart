import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/fieldContainer.dart';

class CVViewer extends StatelessWidget {
  const CVViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundTemplate(
        title: 'Applicant\'s CV',
        child: Column(
          children: [
            FieldContainer(
              title: 'Full Name',
              child: Text('siapa'),
            ),
            SizedBox(height: 24),
            FieldContainer(
              title: 'Phone Number',
              child: Text('0987654321'),
            ),
          ],
        ));
  }
}
