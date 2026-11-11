class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final int reviewsCount;
  final String nextAvailable;
  final String price;
  final bool insuranceCovered;
  final List<String> availableDays;
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
