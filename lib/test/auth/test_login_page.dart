// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/test/auth/test_register_page.dart';
import 'package:login_app/test/corporate/test_corporate_bottom_navbar.dart';
import 'package:login_app/test/jobseeker/test_jobseeker_bottom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<String> getUserType(String uid) async {
    try {
      // Query and check If the UID exists in Jobseekers or Corporations and return unknown if not found
      final jobseekerDoc = await firestore.collection('Users/Role/Jobseekers').doc(uid).get();
      final corporateDoc = await firestore.collection('Users/Role/Corporations').doc(uid).get();

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Log In'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();

        final authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = authResult.user;

        final userType = await getUserType(user!.uid);

        setState(() {
          _isLoading = false;
        });

        print(userType);

        if (userType == 'jobseeker') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const JobseekerNavbar()), // Replace with your jobseeker home page
          );
        } else if (userType == 'corporate') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CorporateNavbar()), // Replace with your corporate home page
          );
        } else {
          print("here");
          // Handle unknown user type
          // You can show an error message or navigate to a default page
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        // Handle login errors (e.g., invalid credentials)
        print('Login error: $e');
        // You can display a snackbar or error message to the user here
      }
    }
  }

}
