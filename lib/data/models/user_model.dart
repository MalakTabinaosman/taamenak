class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String nationalId;
  final String insuranceId;
  final String policyNumber;
  final int coveragePercentage;
  final String validUntil;

  const UserModel({
    this.id = '',
    required this.name,
    this.email = '',
    this.phone = '',
    this.nationalId = '',
    this.insuranceId = '',
    this.policyNumber = 'POL-984210',
    this.coveragePercentage = 100,
    this.validUntil = 'ديسمبر ٢٠٢٦',
  });
}
