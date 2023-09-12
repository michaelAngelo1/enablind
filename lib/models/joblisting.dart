class Joblisting {
  String jobTitle;
  String jobDescription;
  String jobQualifications;
  String jobType;
  String jobSalary;
  String corpLogo;
  String corpName;
  bool isFreelance;
  DateTime jobListingPublishDate = DateTime.now();
  DateTime? jobListingCloseDate;

  // Named constructor with default values
  Joblisting({
    this.jobTitle = '',
    this.jobDescription = '',
    this.jobQualifications = '',
    this.jobType = '',
    this.jobSalary = '',
    this.corpLogo = '',
    this.corpName = '',
    this.isFreelance = false,
    DateTime? jobListingCloseDate,
  }) : jobListingCloseDate = null;
}
