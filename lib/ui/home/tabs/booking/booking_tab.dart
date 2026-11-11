import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/custom_header.dart';
import 'package:taamenak/core/widgets/empty_state_widget.dart';
import 'package:taamenak/core/widgets/filter_tabs_bar.dart';
import 'package:taamenak/data/models/doctor_model.dart';
import 'package:taamenak/ui/home/tabs/booking/widgets/booking_confirmation_sheet.dart';
import 'package:taamenak/ui/home/tabs/booking/widgets/doctor_card.dart';

class BookingTab extends StatefulWidget {
  static const String routeName = '/booking';

  const BookingTab({super.key});

  @override
  State<BookingTab> createState() => _BookingTabState();
}

class _BookingTabState extends State<BookingTab> {
  final TextEditingController _searchController = TextEditingController();
  String selectedSpecialty = 'الكل';
  String searchQuery = '';

  final List<String> specialties = const [
    'الكل',
    'قلب وأوعية دموية',
    'باطنة',
    'أسنان',
    'عيون',
    'أطفال',
    'عظام',
    'جلدية',
  ];

  final List<DoctorModel> allDoctors = const [
    DoctorModel(
      id: 'doc-1',
      name: 'د. هاني عادل',
      specialty: 'استشاري قلب وأوعية دموية',
      hospital: 'مستشفى النيل',
      rating: 4.9,
      reviewsCount: 124,
      nextAvailable: 'اليوم • ٠٥:٠٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    DoctorModel(
      id: 'doc-2',
      name: 'د. منى عادل',
      specialty: 'استشاري قلب وأوعية دموية',
      hospital: 'مستشفى النيل',
      rating: 4.8,
      reviewsCount: 98,
      nextAvailable: 'غداً • ٠١:٣٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    DoctorModel(
      id: 'doc-3',
      name: 'د. أحمد محمد',
      specialty: 'استشاري باطنة وجهاز هضمي',
      hospital: 'مستشفى السلام الدولي',
      rating: 4.9,
      reviewsCount: 215,
      nextAvailable: 'اليوم • ٠٧:٠٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    DoctorModel(
      id: 'doc-4',
      name: 'د. سارة محمود',
      specialty: 'أخصائية جلدية وتجميل',
      hospital: 'مركز الشفاء الطبي',
      rating: 4.7,
      reviewsCount: 86,
      nextAvailable: 'الأربعاء • ٠٤:٠٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
    DoctorModel(
      id: 'doc-5',
      name: 'د. طارق سعيد',
      specialty: 'استشاري طب وجراحة العيون',
      hospital: 'مستشفى دار العيون',
      rating: 4.9,
      reviewsCount: 140,
      nextAvailable: 'الخميس • ٠٦:٣٠ م',
      price: 'مغطى بالكامل (تأمينك)',
    ),
  ];

  List<DoctorModel> get filteredDoctors {
    return allDoctors.where((doc) {
      final matchesSpecialty = selectedSpecialty == 'الكل' ||
          doc.specialty.contains(selectedSpecialty);
      final query = searchQuery.trim();
      final matchesSearch = query.isEmpty ||
          doc.name.contains(query) ||
          doc.specialty.contains(query) ||
          doc.hospital.contains(query);
      return matchesSpecialty && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Screen Header
              CustomHeader(
                title: 'احجز موعد',
                trailing: const HeaderBadge(
                  label: 'تأمين معتمد',
                  icon: Icons.local_hospital_outlined,
                ),
              ),

              const SizedBox(height: 6),

            

              const SizedBox(height: 12),

              // Specialties Chips
              FilterChipBar(
                items: specialties,
                selectedItem: selectedSpecialty,
                onSelected: (item) {
                  setState(() {
                    selectedSpecialty = item;
                  });
                },
              ),

              const SizedBox(height: 10),

              // Doctors List
              Expanded(
                child: filteredDoctors.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.search_off_outlined,
                        title: 'لا يوجد أطباء مطابقين للبحث',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        itemCount: filteredDoctors.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final doc = filteredDoctors[index];
                          return DoctorCard(
                            doctor: doc,
                            onBook: () => showBookingConfirmationSheet(
                              context: context,
                              doctor: doc,
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
