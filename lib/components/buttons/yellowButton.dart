import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const YellowButton({
    super.key,
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
            borderRadius: BorderRadius.circular(12.0), // Rounded edges
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(screenWidth - 48, 55),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
