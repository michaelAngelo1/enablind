import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
