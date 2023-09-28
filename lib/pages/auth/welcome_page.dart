import 'package:flutter/material.dart';
import 'package:login_app/components/buttons/googleButton.dart';
import 'package:login_app/pages/auth/choose_page.dart';
import 'package:login_app/pages/auth/loginEmail_page.dart';
import 'package:login_app/pages/auth/registerEmail_page.dart';
import 'package:login_app/variables.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Text(
                'Welcome to\nenablind',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  print('sign up button clicked');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterEmailPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(accentColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(screenWidth - 48, 55),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sign up with Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              TextButton(
                onPressed: () {
                  print('log in button clicked');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginEmailPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(accentColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(screenWidth - 48, 55),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
