import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class BackgroundTemplate extends StatelessWidget {
  final Widget child; // The content of the page
  final String title;

  BackgroundTemplate({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        //container luar
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                //container abu2 glass
                width: screenWidth - 20, // Subtract 10 pixels from both sides
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 20.0, //20
                  right: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight:
                          Radius.circular(32.0)), // Adjust the radius as needed
                  color: cardJobListColor, // Set the background color
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
