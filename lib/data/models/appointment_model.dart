// ========================================================
// نموذج بيانات الموعد والحجز (AppointmentModel)
// يمثل بيانات موعد الكشف المحجوز في شاشة المواعيد والرئيسية
// ========================================================
class AppointmentModel {
  /// المعرف الفريد للموعد في قاعدة البيانات
  final String id;

  /// اليوم من الشهر (مثلاً: ٢٤)
  final String day;

  /// اسم الشهر (مثلاً: يونيو)
  final String month;

  /// عنوان الموعد أو اسم الطبيب (مثلاً: د. منى عادل)
  final String title;

  /// التخصص الطبي أو الوصف (مثلاً: استشاري أسنان وجراحة الفم)
  final String subtitle;

  /// اسم المستشفى أو العيادة
  final String hospital;

  /// توقيت الموعد (مثلاً: ٠٦:٠٠ م)
  final String time;

  const AppointmentModel({
    this.id = '',
    required this.day,
    required this.month,
    required this.title,
    required this.subtitle,
    required this.hospital,
    required this.time,
  });
}
