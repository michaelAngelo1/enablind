
class Corporate {
  // Wajib diisi saat Regist
  String corporationName;
  String phoneNumber;
  DateTime? foundingDate;
  // Diisi di Corporate Profile
  String? aboutUs;
  DateTime registrationDate = DateTime.now();

  // Basic Corporate Constructor
  Corporate({
    this.corporationName = '',
    this.phoneNumber = '',
  });

}