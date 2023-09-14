// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/pages/auth/loginPassword_page.dart';
import 'package:login_app/pages/auth/registerPassword_page.dart';
import 'package:login_app/test/auth/test_register_page.dart';
import 'package:login_app/test/auth/test_register_select_page.dart';
import 'package:login_app/test/corporate/test_corporate_bottom_navbar.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_bottom_navbar.dart';
import 'package:login_app/variables.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  RegisterEmailPageState createState() => RegisterEmailPageState();
}

class RegisterEmailPageState extends State<RegisterEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                'Create an Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  semanticCounterText: 'Please enter your email',
                  fillColor: Color.fromARGB(255, 74, 74, 75),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 74, 74, 75)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 62, 67, 74)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return _validateEmail(value);
                },
              ),
              const SizedBox(height: 20.0),
              YellowButton(
                onPressed: _isLoading ? null : _nextPage,
                label: _isLoading ? 'loading..' : 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nextPage() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      print(_emailController.text.trim());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPasswordPage(
            emailParam: _emailController.text.trim(),
          ),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _validateEmail(String value) {
    // Define a regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }
}
