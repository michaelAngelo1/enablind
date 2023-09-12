import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/test/auth/test_auth_page.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// import 'package:login_app/app_state.dart';
// import 'package:provider/provider.dart';
// import 'package:login_app/pages/auth/select_page.dart';
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AppState(),
//       child: const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: SelectPage(),
//       ),
//     );
//   }
// }



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}