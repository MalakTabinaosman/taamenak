// ========================================================
// نموذج بيانات الطبيب (DoctorModel)
// يمثل بيانات الأطباء المتاحين للحجز في شاشة الحجز
// ========================================================
class DoctorModel {
  /// المعرف الفريد للطبيب
  final String id;

  /// اسم الطبيب (مثلاً: د. هاني عادل)
  final String name;

  /// التخصص الطبي (مثلاً: استشاري قلب وأوعية دموية)
  final String specialty;

  /// اسم المستشفى أو المركز الطبي التابع له
  final String hospital;

  /// التقييم من 5 نجوم (مثلاً: 4.9)
  final double rating;

  /// عدد التقييمات والمراجعات
  final int reviewsCount;

  /// أقرب موعد متاح للكشف
  final String nextAvailable;

  /// سعر الكشف أو حالة تغطية التأمين
  final String price;

  /// هل الكشف مغطى بالتأمين الصحي أم لا
  final bool insuranceCovered;

  /// الأيام المتاحة للحجز
  final List<String> availableDays;

  /// الأوقات والمواعيد المتاحة خلال اليوم
  final List<String> availableSlots;

  const DoctorModel({
    this.id = '',
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.reviewsCount,
    required this.nextAvailable,
    required this.price,
    this.insuranceCovered = true,
    this.availableDays = const [
      'اليوم (٢٤ يونيو)',
      'غداً (٢٥ يونيو)',
      'بعد غد (٢٦ يونيو)',
    ],
    this.availableSlots = const [
      '٠٥:٠٠ م',
      '٠٥:٣٠ م',
      '٠٦:٠٠ م',
      '٠٦:٣٠ م',
      '٠٧:٠٠ م',
    ],
  });

  /// دالة لنسخ النموذج مع تعديل بعض القيم
  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialty,
    String? hospital,
    double? rating,
    int? reviewsCount,
    String? nextAvailable,
    String? price,
    bool? insuranceCovered,
    List<String>? availableDays,
    List<String>? availableSlots,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      hospital: hospital ?? this.hospital,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      nextAvailable: nextAvailable ?? this.nextAvailable,
      price: price ?? this.price,
      insuranceCovered: insuranceCovered ?? this.insuranceCovered,
      availableDays: availableDays ?? this.availableDays,
      availableSlots: availableSlots ?? this.availableSlots,
    );
  }
}
