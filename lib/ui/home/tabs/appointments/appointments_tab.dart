import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/custom_header.dart';
import 'package:taamenak/core/widgets/empty_state_widget.dart';
import 'package:taamenak/data/models/appointment_model.dart';
import 'package:taamenak/ui/home/tabs/appointments/widgets/appointment_card.dart';

class AppointmentsTab extends StatefulWidget {
  static const String routeName = '/appointments';

  const AppointmentsTab({super.key});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  List<AppointmentModel> allAppointments = [
    const AppointmentModel(
      id: '1',
      day: '٢٤',
      month: 'يونيو',
      title: 'د. هاني عادل',
      subtitle: 'استشاري قلب وأوعية دموية',
      hospital: 'مستشفى النيل',
      time: '١٠:٠٠ ص - ١:٠٠ م',
    ),
    const AppointmentModel(
      id: '2',
      day: '٢٨',
      month: 'يونيو',
      title: 'تحليل صورة دم كاملة (CBC)',
      subtitle: 'معمل مستشفى النيل',
      hospital: 'مستشفى النيل',
      time: '٩:٠٠ ص',
    ),
    const AppointmentModel(
      id: '3',
      day: '١٥',
      month: 'يونيو',
      title: 'د. أحمد محمد',
      subtitle: 'استشاري باطنة وجهاز هضمي',
      hospital: 'مستشفى النيل',
      time: '١١:٠٠ ص',
    ),
    const AppointmentModel(
      id: '4',
      day: '٠٢',
      month: 'يونيو',
      title: 'د. سارة محمود',
      subtitle: 'أخصائية جلدية وتجميل',
      hospital: 'مركز الشفاء الطبي',
      time: '٠٥:٣٠ م',
    ),
    const AppointmentModel(
      id: '5',
      day: '١٠',
      month: 'يونيو',
      title: 'كشف أسنان دوري',
      subtitle: 'عيادة الأسنان التخصصية',
      hospital: 'مستشفى النيل',
      time: '١٢:٠٠ م',
    ),
  ];

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
              CustomHeader(title: 'مواعيدي'),

              const SizedBox(height: 10),

              // Content List or Empty State
              Expanded(
                child: allAppointments.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.event_note_outlined,
                        title: 'لا توجد مواعيد حالياً',
                       
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        itemCount: allAppointments.length,
                        itemBuilder: (context, index) {
                          final appointment = allAppointments[index];
                          return AppointmentCard(
                            appointment: appointment,
                            onTap: () => (
                              context: context,
                              appointment: appointment,
                              onCancel: () => (appointment),
                              onReschedule: () => (appointment, '٠٢:٠٠ م'),
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

// Backward compatibility alias
typedef AppointmentsScreen = AppointmentsTab;
