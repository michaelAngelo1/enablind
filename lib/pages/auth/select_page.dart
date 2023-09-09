import 'package:flutter/material.dart';
import 'package:login_app/app_state.dart';
import 'package:login_app/pages/auth/auth_page.dart';
import 'package:provider/provider.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                appState.setIsCorporate(true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              }, 
              child: const Text("I'm Corporate")
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.setIsCorporate(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              }, 
              child: const Text("I'm A Jobseeker")
            )
          ],
        ),
      )
    );
  }
}