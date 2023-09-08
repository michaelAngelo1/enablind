import 'package:flutter/material.dart';
import 'package:login_app/db_instance.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = auth.currentUser!;

  void signUserOut() {
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text("LOGGED IN as ${user.email!}")),
    );
  }
}
