import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_app/variables.dart';

class UpdatesSeeker extends StatefulWidget {
  const UpdatesSeeker({super.key});

  @override
  State<UpdatesSeeker> createState() => _UpdatesSeekerState();
}

class _UpdatesSeekerState extends State<UpdatesSeeker> {
  @override

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: titleJobCardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "No updates yet.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: titleContentColor,
            )
          )
        ]
      )
    );
  }
}