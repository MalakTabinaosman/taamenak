import 'package:flutter/material.dart';
import 'package:taamenak/core/modal/appointment_modal.dart';
import 'package:taamenak/core/widgets/card_widget.dart';

class AppointmentsTab extends StatefulWidget {
  static const String routeName = '/appointments';

  const AppointmentsTab({super.key});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

// Alias for backwards compatibility
typedef AppointmentsScreen = AppointmentsTab;

class _AppointmentsTabState extends State<AppointmentsTab> {
  int selectedTab = 0;

  // بيانات الحجوزات منظمة حسب الحالة
  final List<List<AppointmentModel>> appointments = [
    // القادمة
    [
      const AppointmentModel(
        day: '٢٤',
        month: 'يونيو',
        title: 'د. هاني عادل',
        subtitle: 'استشاري قلب وأوعية دموية',
        hospital: 'مستشفى النيل',
        time: '١٠:٠٠ ص - ١:٠٠ م',
        status: 'مؤكد',
      ),
      const AppointmentModel(
        day: '٢٨',
        month: 'يونيو',
        title: 'تحليل صورة دم كاملة (CBC)',
        subtitle: 'معمل مستشفى النيل',
        hospital: 'مستشفى النيل',
        time: '٩:٠٠ ص',
        status: 'قيد التأكيد',
      ),
    ],
    // المكتملة
    [
      const AppointmentModel(
        day: '١٥',
        month: 'يونيو',
        title: 'د. أحمد محمد',
        subtitle: 'استشاري باطنة وجهاز هضمي',
        hospital: 'مستشفى النيل',
        time: '١١:٠٠ ص',
        status: 'مكتمل',
      ),
      const AppointmentModel(
        day: '٠2',
        month: 'يونيو',
        title: 'د. سارة محمود',
        subtitle: 'أخصائية جلدية وتجميل',
        hospital: 'مركز الشفاء الطبي',
        time: '٠٥:٣٠ م',
        status: 'مكتمل',
      ),
    ],
    // الملغاة
    [
      const AppointmentModel(
        day: '١٠',
        month: 'يونيو',
        title: 'كشف أسنان دوري',
        subtitle: 'عيادة الأسنان التخصصية',
        hospital: 'مستشفى النيل',
        time: '١٢:٠٠ م',
        status: 'ملغي',
      ),
    ],
  ];

  final List<String> tabTitles = ['القادمة', 'المكتملة', 'الملغاة'];

  void _showAppointmentDetails(AppointmentModel appointment) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
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
                      'تفاصيل الحجز',
                      style: tt.titleLarge?.copyWith(
                        color: cs.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: cs.secondary.withValues(alpha: 0.6)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppointmentCard(appointment: appointment),
                const SizedBox(height: 16),
                _buildDetailRow(
                  icon: Icons.verified_user_outlined,
                  title: 'التغطية التأمينية',
                  value: 'مغطى بنسبة 100% عبر تأمينك',
                  color: cs.primary,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.pin_drop_outlined,
                  title: 'العنوان',
                  value: appointment.hospital.isNotEmpty
                      ? '${appointment.hospital} - شارع الدقي الرئيسي'
                      : 'المركز الرئيسي',
                  color: cs.secondary,
                ),
                const SizedBox(height: 20),
                if (appointment.status == 'مؤكد' || appointment.status == 'قيد التأكيد') ...[
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم إلغاء الموعد')),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: cs.error),
                            foregroundColor: cs.error,
                            backgroundColor: cs.error.withValues(alpha: 0.05),
                          ),
                          child: const Text('إلغاء الموعد'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم إرسال طلب إعادة الجدولة')),
                            );
                          },
                          child: const Text('إعادة الجدولة'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.onSurface.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: tt.bodySmall?.copyWith(
                    color: cs.secondary.withValues(alpha: 0.6),
                    fontSize: 11,
                  ),
                ),
                Text(
                  value,
                  style: tt.bodyMedium?.copyWith(
                    color: cs.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'مواعيدي',
                      style: tt.displayLarge?.copyWith(
                        fontSize: 22,
                        color: cs.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
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
                            Icons.calendar_month_outlined,
                            size: 16,
                            color: cs.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'الحجوزات',
                            style: tt.labelMedium?.copyWith(
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

              const SizedBox(height: 16),

              // Filter Tabs (تبويبات الحالات مع هوية التطبيق)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: cs.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Row(
                    children: List.generate(tabTitles.length, (index) {
                      final isSelected = selectedTab == index;
                      final count = appointments[index].length;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTab = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? cs.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tabTitles[index],
                                  style: tt.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : cs.secondary.withValues(alpha: 0.6),
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white.withValues(alpha: 0.25)
                                        : cs.secondary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '$count',
                                    style: tt.labelSmall?.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : cs.secondary.withValues(alpha: 0.7),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Appointments List / Empty State
              Expanded(
                child: appointments[selectedTab].isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  color: cs.primary.withValues(alpha: 0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.event_note_outlined,
                                  size: 34,
                                  color: cs.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'لا توجد مواعيد في هذا القسم',
                                style: tt.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: cs.secondary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'يمكنك تصفح الأطباء والمستشفيات وحجز موعد جديد',
                                style: tt.bodySmall?.copyWith(
                                  color: cs.secondary.withValues(alpha: 0.6),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        itemCount: appointments[selectedTab].length,
                        itemBuilder: (context, index) {
                          final appointment = appointments[selectedTab][index];
                          return AppointmentCard(
                            appointment: appointment,
                            onTap: () => _showAppointmentDetails(appointment),
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
