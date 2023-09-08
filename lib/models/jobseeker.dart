
class Jobseeker {
  // Wajib diisi saat Regist
  String username;
  String fullName;
  String email;
  String phoneNum;
  DateTime? dateOfBirth;
  String? gender;
  // Diisi di Profile
  String? pathSuratKeteranganDisabilitas;
  String? aboutMe;
  DateTime registrationDate = DateTime.now();

  // Basic Jobseeker Constructor
  Jobseeker({
    this.username = '',
    this.fullName = '',
    this.email = '',
    this.phoneNum = '',
  });

}