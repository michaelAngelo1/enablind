import 'package:flutter/material.dart';
import 'package:login_app/components/backgroundPage.dart';
import 'package:login_app/components/buttons/bottomButton.dart';

class AboutEnablind extends StatelessWidget {
  const AboutEnablind({super.key});
  final String aboutEnablind = 'Enablind is an innovative and inclusive mobile '
      'app specifically designed to support the blind '
      'and visually impaired in their job search. This '
      'app ensures to bring the concept of remote work '
      'whereby every job seeker with visual disabilities '
      ' has equal access to job opportunities without '
      'having to face travel or physical mobility constraints. '
      'With Enablind, users can feel confident in finding jobs '
      'that match their interests, skills and abilities';

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    return BackgroundTemplate(
      title: 'About Enablind',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.transparent,
                  height: 100,
                  width: 100,
                  child: const Image(
                    image: AssetImage(
                      'lib/images/enablindAbout.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Color.fromARGB(255, 218, 213, 213)),
            const SizedBox(height: 8),
            SizedBox(
              width: screenSize * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF8FAFC),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    aboutEnablind,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xFFAAAFD7),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            BottomButton(
              label: 'OK',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
