import 'package:cloud_firestore/cloud_firestore.dart';

class Joblisting {
  String jobTitle;
  String jobDescription;
  List<dynamic> jobQualifications;
  String jobType;
  int jobSalary;
  String corpLogo;
  String corpName;
  bool isFreelance;
  Timestamp jobListingPublishDate = Timestamp.now();
  Timestamp? jobListingCloseDate;

  // Named constructor with default values
  Joblisting({
    this.jobTitle = '',
    this.jobDescription = '',
    this.jobQualifications = const [],
    this.jobType = '',
    this.jobSalary = 0,
    this.corpLogo = '',
    this.corpName = '',
    this.isFreelance = false,
    Timestamp? jobListingCloseDate,
  }) : jobListingCloseDate = null;
}
