import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class BottomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const BottomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(20),
              shadowColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
              minimumSize: MaterialStateProperty.all<Size>(const Size(350, 55)),
              backgroundColor: MaterialStateProperty.all<Color>(accentColor)),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
