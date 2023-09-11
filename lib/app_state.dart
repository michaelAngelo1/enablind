
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool isCorporate = false;
  String ?currentUID;

  List jobListing = [];
  List updates = [];
  

  updateUID(String uid) {
    currentUID = uid;
    print(currentUID);
  }

  setIsCorporate (bool status) {
    isCorporate = status;
    print(isCorporate);
  }
}