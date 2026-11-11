import 'package:flutter/material.dart';
import 'package:taamenak/data/models/appointment_model.dart';
import 'package:taamenak/data/models/prescription_model.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/home_header_section.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/next_appointment_section.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/quick_services_section.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/recent_prescriptions_section.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/widgets/prescription_details_sheet.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = '/homepage';
  final ValueChanged<int>? onNavigateTab;

  const HomeTab({super.key, this.onNavigateTab});

  final AppointmentModel sampleNextAppointment = const AppointmentModel(
    id: 'next-1',
    day: '٢٤',
    month: 'يونيو',
    title: 'د. منى عادل',
    subtitle: 'استشاري قلب وأوعية دموية',
    hospital: 'مستشفى النيل',
    time: '٠١:٣٠ م',
   
  );

  final PrescriptionModel sampleRecentPrescription = const PrescriptionModel(
    id: 'rx-2048',
    orderNumber: '#RX-2048',
    pharmacyName: 'صيدلية العزبي',
    branch: 'فرع الدقي',
    dateStr: 'اليوم، ١١:٤٥ ص',
    status: 'في انتظار الرد',
    itemsCount: 3,
    notes: 'أدوية ضغط وڤيتامينات شهرية',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeaderSection(
                  userName: 'سارة',
                ),
              
                const SizedBox(height: 18),
                NextAppointmentSection(
                  appointment: sampleNextAppointment,
                  onViewAll: () => onNavigateTab?.call(3), // appointments tab
                  onTap: () => (
                    context: context,
                    appointment: sampleNextAppointment,
                  ),
                ),
                const SizedBox(height: 18),
                QuickServicesSection(
                  onServiceTap: onNavigateTab,
                ),
                const SizedBox(height: 18),
                RecentPrescriptionsSection(
                  prescription: sampleRecentPrescription,
                  onViewAll: () => onNavigateTab?.call(2), // prescriptions tab
                  onTap: () => showPrescriptionDetailsSheet(
                    context,
                    sampleRecentPrescription,
                  ),
                ),
                const SizedBox(height: 16),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
