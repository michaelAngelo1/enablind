import 'package:flutter/material.dart';
import 'package:login_app/pages/auth/newCorporateForm_page.dart';
import 'package:login_app/pages/auth/newJobseekerForm_page.dart';
import 'package:login_app/test/auth/test_register_corporate_page.dart';
import 'package:login_app/test/auth/test_register_jobseeker_page.dart';
import 'package:login_app/variables.dart';

class ChoosePage extends StatelessWidget {
  const ChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 120),
              const Text(
                'You are a..',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                icon: Icons.person,
                label: "Jobseeker",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewJobseekerForm()),
                  );
                },
              ),
              SizedBox(height: 18),
              Stack(children: <Widget>[
                Divider(color: Color.fromARGB(255, 218, 213, 213)),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    color: bgColor,
                    child: const Text(
                      'or',
                      style: TextStyle(
                        color: Color.fromARGB(255, 218, 213, 213),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 18),
              CustomButton(
                icon: Icons.business,
                label: 'Corporate',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewCorporateForm()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const CustomButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(accentColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(screenWidth - 48, 85),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
