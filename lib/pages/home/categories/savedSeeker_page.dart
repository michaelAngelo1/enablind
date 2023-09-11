import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class SavedSeeker extends StatefulWidget {
  const SavedSeeker({super.key});

  @override
  State<SavedSeeker> createState() => _SavedSeekerState();
}

class _SavedSeekerState extends State<SavedSeeker> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: topbarColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              
            ]
          )
        )
      )
    );
  }
}