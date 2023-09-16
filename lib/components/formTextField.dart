import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class FormTextField extends StatelessWidget {
  final controller;
  final String title;
  final String hintText;
  final String semanticCounterText;
  final TextInputType? keyboardType;

  const FormTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.semanticCounterText,
    this.keyboardType,
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
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
            semanticCounterText: semanticCounterText,
            fillColor: Color.fromARGB(255, 74, 74, 75),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 74, 74, 75)),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 62, 67, 74)),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return semanticCounterText;
            }
            return null;
          },
        ),
      ],
    );
  }
}
