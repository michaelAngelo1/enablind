import 'package:firebase_core/firebase_core.dart' as core;
import 'package:flutter/foundation.dart';
import 'db_instance.dart';

class Storage {
  Future<String> handleUploadPhoto(
    final filebytes,
    final filename,
  ) async {

    try {
      // CHECK USER IS CORPORATE OR JOBSEEKER
      final jobseekerDoc =
          await fsdb.collection('Users/Role/Jobseekers').doc(filename).get();
      final corporateDoc =
          await fsdb.collection('Users/Role/Corporations').doc(filename).get();
      
      if(jobseekerDoc.exists) {
        await storage.ref('users/jobseeker/$filename').putData(filebytes);
      } else if(corporateDoc.exists) {
        await storage.ref('users/corporate/$filename').putData(filebytes);
      }
      return "Upload success";
    } on core.FirebaseException catch (e) {
      if(kDebugMode) {
        print("Error getting image: $e");
      }
      return "Error getting image";
    }
  }

  Future<String> handleImageURL(
    final uidFilename,
  ) async {
    try {
      final String downloadURL;
      final jobseekerDoc =
          await fsdb.collection('Users/Role/Jobseekers').doc(uidFilename).get();
      final corporateDoc =
          await fsdb.collection('Users/Role/Corporations').doc(uidFilename).get();
      var photoRef;
      if(jobseekerDoc.exists) {
        photoRef = storage.ref().child("users/jobseeker/$uidFilename");
      } else if(corporateDoc.exists) {
        photoRef = storage.ref().child("users/corporate/$uidFilename");
      }
      

      downloadURL = await photoRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print("Error getting image URL: $e");
      return 'Error getting image';
    }
  }
}