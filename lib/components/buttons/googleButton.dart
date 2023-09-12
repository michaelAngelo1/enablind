import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {
        // TO-do : Handle Google sign-in action
        print('google button clicked');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(cardJobListColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(screenWidth - 48, 55),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'lib/images/google.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Center(
                child: Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: Colors.white,
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
