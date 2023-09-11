class Joblisting {
  String jobTitle;
  String jobDescription;
  String jobQualifications;
  String jobType;
  String jobSalary;
  String corpLogo;
  String corpName;
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
    DateTime? jobListingCloseDate,
  }) : jobListingCloseDate = null;
}
