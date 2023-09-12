import 'package:firebase_core/firebase_core.dart' as core;

import 'db_instance.dart';

class Storage {

  Future<void> uploadPhoto(
    final filebytes,
    final filename,
  ) async {

    try {
      await storage.ref('profilepic/$filename').putData(filebytes);
    } on core.FirebaseException catch (e) {
      print(e);
    }
  }
}