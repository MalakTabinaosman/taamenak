import 'package:flutter/material.dart';

class DoctorBookingItem {
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final int reviewsCount;
  final String nextAvailable;
  final String price;
  final bool insuranceCovered;

  const DoctorBookingItem({
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.reviewsCount,
    required this.nextAvailable,
    required this.price,
    this.insuranceCovered = true,
  });
}

class BookingTab extends StatefulWidget {
  static const String routeName = '/booking';

  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  String selectedSpecialty = 'الكل';
  final TextEditingController _searchController = TextEditingController();

  final List<String> specialties = [
    'الكل',
    'قلب وأوعية دموية',
    'باطنة',
    'أسنان',
    'عيون',
    'أطفال',
    'عظام',
    'جلدية',
  ];

  final List<DoctorBookingItem> doctors = [
    const DoctorBookingItem(
      name: 'د. هاني عادل',
      specialty: 'استشاري قلب وأوعية دموية',
      hospital: 'مستشفى النيل',
      rating: 4.9,
      reviewsCount: 124,
      nextAvailable: 'اليوم • ٠٥:٠٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    const DoctorBookingItem(
      name: 'د. منى عادل',
      specialty: 'استشاري قلب وأوعية دموية',
      hospital: 'مستشفى النيل',
      rating: 4.8,
      reviewsCount: 98,
      nextAvailable: 'غداً • ٠١:٣٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    const DoctorBookingItem(
      name: 'د. أحمد محمد',
      specialty: 'استشاري باطنة وجهاز هضمي',
      hospital: 'مستشفى السلام الدولي',
      rating: 4.9,
      reviewsCount: 215,
      nextAvailable: 'اليوم • ٠٧:٠٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    const DoctorBookingItem(
      name: 'د. سارة محمود',
      specialty: 'أخصائية جلدية وتجميل',
      hospital: 'مركز الشفاء الطبي',
      rating: 4.7,
      reviewsCount: 86,
      nextAvailable: 'الأربعاء • ٠٤:٠٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    const DoctorBookingItem(
      name: 'د. طارق سعيد',
      specialty: 'استشاري طب وجراحة العيون',
      hospital: 'مستشفى دار العيون',
      rating: 4.9,
      reviewsCount: 140,
      nextAvailable: 'الخميس • ٠٦:٣٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
  ];

  List<DoctorBookingItem> get filteredDoctors {
    return doctors.where((doc) {
      final matchesSpecialty = selectedSpecialty == 'الكل' ||
          doc.specialty.contains(selectedSpecialty);
      final query = _searchController.text.trim();
      final matchesSearch = query.isEmpty ||
          doc.name.contains(query) ||
          doc.specialty.contains(query) ||
          doc.hospital.contains(query);
      return matchesSpecialty && matchesSearch;
    }).toList();
  }

  void _showBookingSheet(DoctorBookingItem doctor) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    int selectedDayIndex = 0;
    int selectedSlotIndex = 0;

    final days = ['اليوم (٢٤ يونيو)', 'غداً (٢٥ يونيو)', 'بعد غد (٢٦ يونيو)'];
    final timeSlots = ['٠٥:٠٠ م', '٠٥:٣٠ م', '٠٦:٠٠ م', '٠٦:٣٠ م', '٠٧:٠٠ م'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: cs.secondary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تأكيد حجز موعد',
                          style: tt.titleLarge?.copyWith(
                            color: cs.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close,
                              color: cs.secondary.withValues(alpha: 0.6)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Doctor Info Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: cs.primary.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: cs.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: cs.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: tt.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: cs.secondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  doctor.specialty,
                                  style: tt.bodySmall?.copyWith(
                                    color: cs.secondary.withValues(alpha: 0.7),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  doctor.hospital,
                                  style: tt.bodySmall?.copyWith(
                                    color: cs.secondary.withValues(alpha: 0.6),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'اختر اليوم',
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(days.length, (index) {
                          final isSelected = selectedDayIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedDayIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? cs.primary
                                    : cs.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? cs.primary
                                      : cs.onSurface.withValues(alpha: 0.1),
                                ),
                              ),
                              child: Text(
                                days[index],
                                style: tt.bodySmall?.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : cs.secondary,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'المواعيد المتاحة',
                      style: tt.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.secondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(timeSlots.length, (index) {
                        final isSelected = selectedSlotIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedSlotIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? cs.primary.withValues(alpha: 0.12)
                                  : cs.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? cs.primary
                                    : cs.onSurface.withValues(alpha: 0.1),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Text(
                              timeSlots[index],
                              style: tt.bodySmall?.copyWith(
                                color: isSelected
                                    ? cs.primary
                                    : cs.secondary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: cs.primary,
                            content: Text(
                              'تم تأكيد حجزك مع ${doctor.name} بنجاح!',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      child: const Text('تأكيد الحجز الآن'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),

              // Title Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'احجز موعد',
                      style: tt.displayLarge?.copyWith(
                        fontSize: 22,
                        color: cs.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: cs.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: cs.primary.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_hospital_outlined,
                            size: 16,
                            color: cs.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'تأمين معتمد',
                            style: tt.labelSmall?.copyWith(
                              color: cs.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Search Box
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن دكتور، تخصص، أو مستشفى...',
                    hintStyle: tt.bodyMedium?.copyWith(
                      color: cs.secondary.withValues(alpha: 0.4),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: cs.secondary.withValues(alpha: 0.5),
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Specialties Chips
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: specialties.length,
                  itemBuilder: (context, index) {
                    final item = specialties[index];
                    final isSelected = selectedSpecialty == item;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSpecialty = item;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? cs.primary : cs.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? cs.primary
                                : cs.onSurface.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            item,
                            style: tt.bodySmall?.copyWith(
                              color: isSelected ? Colors.white : cs.secondary,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Doctors List
              Expanded(
                child: filteredDoctors.isEmpty
                    ? Center(
                        child: Text(
                          'لا يوجد أطباء مطابقين للبحث',
                          style: tt.bodyMedium?.copyWith(
                            color: cs.secondary.withValues(alpha: 0.5),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        itemCount: filteredDoctors.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final doc = filteredDoctors[index];
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: cs.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: cs.onSurface.withValues(alpha: 0.08),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: cs.secondary.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color:
                                            cs.primary.withValues(alpha: 0.08),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: cs.primary
                                              .withValues(alpha: 0.15),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.medical_services_outlined,
                                        color: cs.primary,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                doc.name,
                                                style: tt.titleMedium?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: cs.secondary,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 14,
                                                    color: Color(0xFFF59E0B),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    '${doc.rating}',
                                                    style:
                                                        tt.labelSmall?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: cs.secondary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            doc.specialty,
                                            style: tt.bodySmall?.copyWith(
                                              color: cs.secondary
                                                  .withValues(alpha: 0.7),
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 13,
                                                color: cs.secondary
                                                    .withValues(alpha: 0.6),
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                doc.hospital,
                                                style: tt.bodySmall?.copyWith(
                                                  color: cs.secondary
                                                      .withValues(alpha: 0.6),
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Divider(height: 1, thickness: 0.5),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time_outlined,
                                          size: 14,
                                          color: cs.primary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          doc.nextAvailable,
                                          style: tt.bodySmall?.copyWith(
                                            color: cs.primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 36,
                                      child: FilledButton(
                                        onPressed: () => _showBookingSheet(doc),
                                        style: FilledButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          minimumSize: Size.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          'احجز الآن',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
