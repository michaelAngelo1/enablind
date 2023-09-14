// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/pages/auth/choose_page.dart';
import 'package:login_app/test/auth/test_register_page.dart';
import 'package:login_app/test/auth/test_register_select_page.dart';
import 'package:login_app/test/corporate/test_corporate_bottom_navbar.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_bottom_navbar.dart';
import 'package:login_app/variables.dart';

class RegisterPasswordPage extends StatefulWidget {
  final String emailParam;
  const RegisterPasswordPage({
    required this.emailParam,
    super.key,
  });

  @override
  RegisterPasswordPageState createState() => RegisterPasswordPageState();
}

class RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _alreadyUsed = false;

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
                'Create your password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  semanticCounterText: 'Please enter your password',
                  fillColor: Color.fromARGB(255, 74, 74, 75),
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 74, 74, 75)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 62, 67, 74)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6)
                    return 'Password should be at least 6 characters';

                  if (_alreadyUsed)
                    return 'The email address is already in use by another account';
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              YellowButton(
                onPressed: _isLoading ? null : _register,
                label: _isLoading ? 'loading..' : 'Create account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final String email = widget.emailParam;
        final String password = _passwordController.text.trim();

        // Register the user with Firebase Authentication
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        setState(() {
          _isLoading = false;
        });

        // After successful registration, you can navigate to the home page or perform any other actions.
        // Example:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ChoosePage()));
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Handle registration errors (e.g., invalid email, weak password, user already exists)
        print('Registration error: $e');
        // You can display a snackbar or error message to the user here
        if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
          setState(() {
            _alreadyUsed = true;
          });
        }
      }
    }
  }
}
