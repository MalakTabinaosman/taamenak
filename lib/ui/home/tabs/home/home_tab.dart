import 'package:flutter/material.dart';
import 'package:taamenak/data/models/appointment_model.dart';
import 'package:taamenak/data/models/prescription_model.dart';
import 'package:taamenak/data/services/user_session.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/home_header_section.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/next_appointment_section.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/quick_services_section.dart';
import 'package:taamenak/ui/home/tabs/home/widgets/recent_prescriptions_section.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/widgets/prescription_details_sheet.dart';

/// ============================================================================
/// تبويب الصفحة الرئيسية (HomeTab)
/// شاشة البداية التي يراها المريض بعد تسجيل الدخول.
/// تحتوي على:
/// 1. الترويسة الترحيبية: باسم المريض المحفوظ في [UserSession].
/// 2. كارت الموعد القادم: يوضح أقرب كشف طبي ومكانه مع خيار عرض الكل.
/// 3. قسم الخدمات السريعة: أزرار مختصرة للحجز، صرف الروشتات، ومعاينة بطاقة التأمين.
/// 4. قسم أحدث الروشتات: يوضح آخر وصفة طبية تم تقديمها وحالتها في الصيدلية.
/// ============================================================================
class HomeTab extends StatelessWidget {
  /// اسم المسار
  static const String routeName = '/homepage';

  /// دالة للتنقل التلقائي إلى التبويبات الأخرى (مثل الانتقال للمواعيد أو الروشتات)
  final ValueChanged<int>? onNavigateTab;

  const HomeTab({super.key, this.onNavigateTab});

  /// بيانات تجريبية لأقرب موعد طبي قادم
  final AppointmentModel sampleNextAppointment = const AppointmentModel(
    id: 'next-1',
    day: '٢٤',
    month: 'يونيو',
    title: 'د. منى عادل',
    subtitle: 'استشاري قلب وأوعية دموية',
    hospital: 'مستشفى النيل',
    time: '٠١:٣٠ م',
  );

  /// بيانات تجريبية لأحدث طلب صرف روشتة
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
                // -------------------------------------------------------------
                // 1. ترويسة الترحيب بالمريض وزر الإشعارات
                // -------------------------------------------------------------
                HomeHeaderSection(
                  userName: UserSession.currentUser.name.isNotEmpty
                      ? UserSession.currentUser.name
                      : 'مريضنا العزيز',
                ),

                const SizedBox(height: 18),

                // -------------------------------------------------------------
                // 2. كارت موعد الكشف الطبي القادم
                // -------------------------------------------------------------
                NextAppointmentSection(
                  appointment: sampleNextAppointment,
                  onViewAll: () => onNavigateTab?.call(3), // التوجه لتبويب المواعيد
                  onTap: () => (
                    context: context,
                    appointment: sampleNextAppointment,
                  ),
                ),

                const SizedBox(height: 18),

                // -------------------------------------------------------------
                // 3. شبكة أزرار الخدمات السريعة (حجز، روشتات، ملف المريض)
                // -------------------------------------------------------------
                QuickServicesSection(
                  onServiceTap: onNavigateTab,
                ),

                const SizedBox(height: 18),

                // -------------------------------------------------------------
                // 4. أحدث الروشتات الطبية المسجلة
                // -------------------------------------------------------------
                RecentPrescriptionsSection(
                  prescription: sampleRecentPrescription,
                  onViewAll: () => onNavigateTab?.call(2), // التوجه لتبويب الروشتات
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
