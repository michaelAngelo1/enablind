import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/pages/auth/home_page.dart';
import 'package:login_app/pages/auth/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              //user is logged in
              if (snapshot.hasData) {
                return HomePage();
              }

              //user not logged in
              else {
                return LoginPage();
              }
            }));
  }
}
