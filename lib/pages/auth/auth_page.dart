import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/db_instance.dart';
import 'package:login_app/pages/auth/home_page.dart';
import 'package:login_app/pages/auth/login_page.dart';
import 'package:login_app/app_state.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context);

    return Scaffold(
        body: StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              //user is logged in
              if (snapshot.hasData) {
                // extract uuid
                final user = snapshot.data;
                final uid = user?.uid;

                // update uuid
                if (uid != null) {
                  appState.updateUID(uid);
                }
                return HomePage();
              }

              //user not logged in
              else {
                return LoginPage();
              }
            }));
  }
}
