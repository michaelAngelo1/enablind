import 'package:flutter/material.dart';
import 'package:login_app/variables.dart';

class customTextfield extends StatelessWidget {
  final controller;
  final String title;
  final String hintText;
  final bool obscureText;
  final bool isMultiline;
  final bool validate;

  const customTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.title = '',
    this.validate = true,
    this.obscureText = false,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        const SizedBox(height: 12),
        TextField(
          maxLines: isMultiline ? null : 1,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(color: Colors.white),
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            semanticCounterText: hintText,
            fillColor: Color.fromARGB(255, 97, 98, 108).withOpacity(0.4),
            filled: true,
            errorText: validate ? null : 'Value can\'t be empty',
            hintText: hintText,
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 141, 158, 167)),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 110, 118, 131)),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 62, 67, 74)),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
