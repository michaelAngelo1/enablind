// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/pages/auth/welcome_page.dart';
import 'package:login_app/pages/corporate/corpHome_page.dart';
import 'package:login_app/pages/home/home_page.dart';
import 'package:login_app/test/corporate/test_corporate_bottom_navbar.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    Future<String> getUserType(String uid) async {
      try {
        // Query and check If the UID exists in Jobseekers or Corporations and return unknown if not found
        final jobseekerDoc =
            await firestore.collection('Users/Role/Jobseekers').doc(uid).get();
        final corporateDoc = await firestore
            .collection('Users/Role/Corporations')
            .doc(uid)
            .get();

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

    return Scaffold(
        body: FutureBuilder<User?>(
      future:
          auth.authStateChanges().first, // Using first to get a single event
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle the case where the authentication state is still loading
          return const CircularProgressIndicator(); // You can use a loading indicator here
        }

        if (snapshot.hasData) {
          final user = snapshot.data;
          final uid = user?.uid;

          return FutureBuilder<String>(
            future: getUserType(uid!),
            builder: (context, userTypeSnapshot) {
              if (userTypeSnapshot.connectionState == ConnectionState.waiting) {
                // Handle the case where the user type is still loading
                return const CircularProgressIndicator(); // You can use a loading indicator here
              }

              final userType = userTypeSnapshot.data;

              // Now, you have the user type, and you can navigate accordingly
              if (userType == 'jobseeker') {
                return HomePage();
              } else if (userType == 'corporate') {
                return CorpHomePage();
              } else {
                return const WelcomePage(); //LoginPage //WelcomPage
              }
            },
          );
        } else {
          return const WelcomePage();
        }
      },
    ));
  }
}
