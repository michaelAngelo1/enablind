import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class CreateJobFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String semanticCounterText;
  final validator;
  final onSaved;
  final TextInputType? keyboardType;

  const CreateJobFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.semanticCounterText,
    required this.validator,
    required this.onSaved,
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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            hintText: hintText,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 74, 74, 75)),
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
          keyboardType: keyboardType,
          validator: validator,
          onSaved: onSaved,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
