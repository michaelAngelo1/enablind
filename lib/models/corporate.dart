
class Corporate {
  // Wajib diisi saat Regist
  String username;
  String corporationName;
  String email;
  String phoneNum;
  DateTime? foundingDate;
  // Diisi di Corporate Profile
  String? aboutUs;
  DateTime registrationDate = DateTime.now();

  // Basic Corporate Constructor
  Corporate({
    this.username = '',
    this.corporationName = '',
    this.email = '',
    this.phoneNum = '',
  });

}