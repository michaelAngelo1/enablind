import 'package:cloud_firestore/cloud_firestore.dart';

class Applicant {
  String fullName;
  String phoneNum;
  String role;
  String address;
  String summary;
  int status;
  List<dynamic> education;
  List<dynamic> experience;
  String profilePicture;
  Timestamp? timestamp;

  // Named constructor with default values
  Applicant({
    this.fullName = '',
    this.phoneNum = '',
    this.role = '',
    this.address = '',
    this.summary = '',
    this.status = -1,
    this.education = const [],
    this.experience = const [],
    this.profilePicture = '',
    Timestamp? timestamp,
  }) : timestamp = null;
}
