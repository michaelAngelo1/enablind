import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(color: Colors.blue)
    );
  }
}