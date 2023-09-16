import 'package:flutter/material.dart';

class FieldContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const FieldContainer({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 18,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 74, 74, 75),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color.fromARGB(255, 74, 74, 75), // White border color
                width: 1, // Border width
              ),
            ),
            child: child,
          ),
        )
      ],
    );
  }
}
