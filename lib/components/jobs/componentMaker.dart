import 'package:flutter/material.dart';
import 'package:login_app/components/jobs/jobCardComponent.dart';
import 'package:login_app/variables.dart';
import 'package:login_app/models/joblisting.dart';

class ComponentTest extends StatelessWidget {
  ComponentTest({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      body: Container(
        //container luar
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Center(
          child: Container(
            //container abu2 glass
            width: screenWidth - 20, // Subtract 10 pixels from both sides
            padding: const EdgeInsets.only(
              top: 40.0,
              // left: 15.0,
              // right: 15.0,
            ),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(32), // Adjust the radius as needed
              color: cardJobListColor, // Set the background color
            ),
            child: Column(
              children: [
                //JOB CARD WIDGET BELLOW

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
