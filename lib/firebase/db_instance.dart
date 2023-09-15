import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseDatabase rtdb = FirebaseDatabase.instance;
FirebaseFirestore fsdb = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;