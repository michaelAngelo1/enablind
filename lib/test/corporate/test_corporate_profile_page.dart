import 'package:flutter/material.dart';
import 'package:login_app/firebase/db_instance.dart';
import 'package:login_app/pages/auth/welcome_page.dart';

class CorporateProfilePage extends StatelessWidget {
  const CorporateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Your App Name'),
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            await auth.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const WelcomePage()));
          },
        ),
      ],
    );
  }
}
