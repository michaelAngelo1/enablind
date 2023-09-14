import 'package:flutter/material.dart';

class FormBox extends StatelessWidget {
  final String labelText;
  final String semanticText;
  final TextInputType keyboardType;
  final Function(String?) onSaved;

  const FormBox({
    super.key,
    required this.labelText,
    required this.semanticText,
    required this.keyboardType,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        semanticCounterText: semanticText,
        fillColor: Color.fromARGB(255, 74, 74, 75),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 74, 74, 75)),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return semanticText;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}
