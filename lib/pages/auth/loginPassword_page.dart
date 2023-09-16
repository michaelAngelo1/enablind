// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/components/buttons/yellowButton.dart';
import 'package:login_app/pages/auth/choose_page.dart';
import 'package:login_app/pages/corporate/corpHome_page.dart';
import 'package:login_app/pages/home/home_page.dart';
import 'package:login_app/test/auth/test_register_page.dart';
import 'package:login_app/test/auth/test_register_select_page.dart';
import 'package:login_app/test/corporate/test_corporate_bottom_navbar.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_bottom_navbar.dart';
import 'package:login_app/variables.dart';

class LoginPasswordPage extends StatefulWidget {
  final String emailParam;
  const LoginPasswordPage({
    required this.emailParam,
    super.key,
  });

  @override
  LoginPasswordPageState createState() => LoginPasswordPageState();
}

class LoginPasswordPageState extends State<LoginPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<String> getUserType(String uid) async {
    try {
      // Query and check If the UID exists in Jobseekers or Corporations and return unknown if not found
      final jobseekerDoc =
          await firestore.collection('Users/Role/Jobseekers').doc(uid).get();
      final corporateDoc =
          await firestore.collection('Users/Role/Corporations').doc(uid).get();

      print(jobseekerDoc);
      print(uid);

      if (jobseekerDoc.exists) {
        return 'jobseeker';
      } else if (corporateDoc.exists) {
        return 'corporate';
      } else {
        return 'unknown';
      }
    } catch (e) {
      print('Error fetching user type: $e');
      return 'error';
    }
  }

  Future<bool> hasUserRegistered(String uid, String userType) async {
    String firestoreQuery = "";
    if (userType == "corporate") {
      firestoreQuery = "Users/Role/Corporations";
    } else if (userType == "jobseeker") {
      firestoreQuery = "Users/Role/Jobseekers";
    }

    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(firestoreQuery)
          .doc(uid)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        if (data != null) {
          final hasRegistered = data['hasRegistered'] as bool?;
          return hasRegistered ??
              false; // Default to false if the field is missing
        }
      }
    } catch (e) {
      print('Error checking user registration: $e');
    }
    return false; // Default to false in case of any error
  }

  bool _isPasswordVisible = false;

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
                'Enter your password',
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
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              YellowButton(
                onPressed: _isLoading ? null : _signIn,
                label: _isLoading ? 'loading..' : 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    print('masuk sign in');
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final String email = widget.emailParam;
        final String password = _passwordController.text.trim();

        print(email);
        print(password);

        final authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = authResult.user;
        final uid = user!.uid;

        final userType = await getUserType(uid);
        bool hasRegistered = await hasUserRegistered(uid, userType);

        setState(() {
          _isLoading = false;
        });

        print(userType);
        print(hasRegistered);

        // check if user has finished registration, if user has been created but not finished registration, will be thrown to select role & input initial data

        if (hasRegistered) {
          if (userType == 'jobseeker') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => WillPopScope(
                      onWillPop: () async {
                        return false;
                      },
                      child:
                          HomePage())), // Replace with your jobseeker home page
            );
          } else if (userType == 'corporate') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CorpHomePage()), // Replace with your corporate home page
            );
          } else {
            print("Unknown user type");
            // Handle unknown user type
            // You can show an error message or navigate to a default page
          }
        } else {
          print("User has not registered yet");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const ChoosePage()), // go to select role & input initial data
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Handle login errors (e.g., invalid credentials)
        print('Login error: $e');
        // You can display a snackbar or error message to the user here
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Semantics(
              label: 'Wrong password',
              child: Text(
                'Wrong password',
                style: TextStyle(color: Colors.black),
              ),
            ),
            backgroundColor: accentColor,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
