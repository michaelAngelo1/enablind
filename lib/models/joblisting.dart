
class Joblisting {
  String jobTitle;
  String jobDescription;
  String jobQualifications;
  String jobType;
  String jobSalary;
  DateTime jobListingPublishDate = DateTime.now();
  DateTime? jobListingCloseDate;

  // Named constructor with default values
  Joblisting({
    this.jobTitle = '',
    this.jobDescription = '',
    this.jobQualifications = '',
    this.jobType = '',
    this.jobSalary = '',
    DateTime? jobListingCloseDate,
  }) : jobListingCloseDate = null;

}