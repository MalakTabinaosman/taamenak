import 'package:flutter/material.dart';
import 'package:taamenak/ui/home/tabs/appointments/appointments_tab.dart';
import 'package:taamenak/ui/home/tabs/booking/booking_tab.dart';
import 'package:taamenak/ui/home/tabs/home/home_tab.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/prescription_tab.dart';
import 'package:taamenak/ui/home/tabs/profile/profile_tab.dart';

/// ============================================================================
/// الشاشة الرئيسية للتطبيق (HomeScreen)
/// الحاوية الأساسية لتطبيق المريض بعد تسجيل الدخول.
/// تحتوي على شريط التنقل السفلي (Bottom Navigation Bar) وتدير التبديل بين 5 تبويبات:
/// 1. الرئيسية (HomeTab): ترحيب المريض، الحجز القادم، الخدمات السريعة، وأحدث الروشتات.
/// 2. احجز (BookingTab): البحث عن الأطباء حسب التخصص وحجز المواعيد.
/// 3. الروشتات (PrescriptionTab): استعراض الروشتات الطبية وصرف الأدوية.
/// 4. مواعيدي (AppointmentsTab): متابعة المواعيد القادمة والسابقة والملغاة.
/// 5. حسابي (ProfileTab): بطاقة التأمين الطبي، المعلومات الشخصية، والإعدادات.
/// تستخدم [IndexedStack] للحفاظ على حالة كل تبويب دون إعادة بنائه عند التنقل.
/// ============================================================================
class HomeScreen extends StatefulWidget {
  /// اسم المسار العام للشاشة الرئيسية
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// فهرس التبويب النشط حالياً (يبدأ من 0 للرئيسية)
  int selectedIndex = 0;

  /// دالة للتنقل البرمجي بين التبويبات (تُمرر لتبويب الرئيسية للروابط السريعة)
  void _onNavigateTab(int index) {
    if (index >= 0 && index < 5 && index != selectedIndex) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // قائمة الشاشات والتبويبات الخمسة
    final List<Widget> screens = [
      HomeTab(onNavigateTab: _onNavigateTab),
      const BookingTab(),
      const PrescriptionTab(),
      const AppointmentsTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      // الحفاظ على حالة الصفحات عند التنقل
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      // -----------------------------------------------------------------------
      // شريط التنقل السفلي المخصص
      // -----------------------------------------------------------------------
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cs.secondary.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: cs.surface,
          elevation: 0,
          selectedItemColor: cs.primary,
          unselectedItemColor: theme.disabledColor,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          onTap: (newIndex) {
            if (newIndex != selectedIndex) {
              setState(() {
                selectedIndex = newIndex;
              });
            }
          },
          items: const [
            // 1. الرئيسية
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            // 2. احجز
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              activeIcon: Icon(Icons.calendar_month),
              label: 'احجز',
            ),
            // 3. الروشتات
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              activeIcon: Icon(Icons.description),
              label: 'الروشتات',
            ),
            // 4. مواعيدي
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time_outlined),
              activeIcon: Icon(Icons.access_time_filled),
              label: 'مواعيدي',
            ),
            // 5. حسابي
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}
