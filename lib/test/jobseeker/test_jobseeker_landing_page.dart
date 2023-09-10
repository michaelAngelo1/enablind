import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/test/auth/test_login_page.dart';

class JobseekerLandingPage extends StatelessWidget {


  const JobseekerLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to Your App'),
      ),
    );
  }
}
