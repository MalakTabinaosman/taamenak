// ========================================================
// نموذج بيانات المريض / المستخدم (UserModel)
// يمثل كائن المريض بجميع تفاصيله المسجلة في التطبيق وبطاقة التأمين
// ========================================================
class UserModel {
  /// المعرف الفريد للمستخدم في قاعدة البيانات (ID)
  final String id;

  /// الاسم بالكامل
  final String name;

  /// البريد الإلكتروني
  final String email;

  /// رقم الهاتف المحمول
  final String phone;

  /// الرقم القومي للمريض (14 رقماً)
  final String nationalId;

  /// رقم عضوية التأمين الصحي
  final String insuranceId;

  /// رقم بوليصة التأمين
  final String policyNumber;

  /// نسبة التغطية التأمينية (مثلاً 100%)
  final int coveragePercentage;

  /// تاريخ انتهاء صلاحية التأمين
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
