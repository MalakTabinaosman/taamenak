import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taamenak/core/theme/app_colors.dart';
import 'package:taamenak/core/theme/app_theme.dart';
import 'package:taamenak/data/services/user_session.dart';
import 'package:taamenak/splash_screen.dart';
import 'package:taamenak/ui/admin/admin_dashboard_screen.dart';
import 'package:taamenak/ui/home/buttom_navigation_bar.dart';
import 'package:taamenak/ui/home/tabs/appointments/appointments_tab.dart';
import 'package:taamenak/ui/home/tabs/booking/booking_tab.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/prescription_tab.dart';
import 'package:taamenak/ui/home/tabs/profile/profile_tab.dart';
import 'package:taamenak/ui/login/login.dart';
import 'package:taamenak/ui/onboarding/onboarding.dart';
import 'package:taamenak/ui/signup/sign_up.dart';

// ========================================================
// نقطة الانطلاق الرئيسية للتطبيق (Main Function)
// ========================================================
Future<void> main() async {
  // التأكد من تهيئة وتجهيز بيئة عمل الفلاتر قبل تشغيل أي كود غير متزامن (async)
  WidgetsFlutterBinding.ensureInitialized();

  // 1. تهيئة وربط سيرفر وقاعدة بيانات Supabase
  await Supabase.initialize(
    url: 'https://ntolepkkqqnbkpqzykxb.supabase.co',
    publishableKey: 'sb_publishable_lrUfevG2ijXa0SshUiqW8A_rb-nV12V',
  );

  // 2. تحميل بيانات جلسة المريض المحفوظة مسبقاً (الاسم، رقم التأمين، إلخ)
  await UserSession.loadUser();

  // 3. تشغيل الـ Widget الأساسي للتطبيق
  runApp(const MyApp());
}

// ========================================================
// الكلاس الرئيسي للواجهة وإعدادات التطبيق العامة (MyApp)
// ========================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // تطبيق الثيم والألوان الموحدة الخاصة بالتطبيق
      theme: AppTheme(LightColors()).theme,

      // إخفاء شريط كلمة Debug في زاوية الشاشة
      debugShowCheckedModeBanner: false,

      // ضبط اللغة الأساسية لتكون العربية (اتجاه من اليمين لليسار RTL)
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // الشاشة الأولى التي تفتح عند تشغيل التطبيق (شاشة البداية Splash)
      initialRoute: '/',

      // جدول مسارات الشاشات في التطبيق (Routing Map)
      routes: {
        '/': (context) => const SplashPage(),                       // شاشة البداية
        '/booking': (context) => const BookingTab(),                 // شاشة حجز الأطباء
        '/prescriptions': (context) => const PrescriptionTab(),     // شاشة الروشتات
        '/appointments': (context) => const AppointmentsTab(),       // شاشة المواعيد
        '/profile': (context) => const ProfileTab(),                 // شاشة حسابي والبروفايل
        '/onboarding': (context) => const OnboardingScreen(),       // شاشة التعريف بالبرنامج
        '/signup': (context) => const SignupScreen(),               // شاشة تسجيل مريض جديد
        '/login': (context) => const LoginScreen(),                 // شاشة تسجيل الدخول
        '/home': (context) => const HomeScreen(),                   // شريط التنقل والشاشة الرئيسية
        '/admin': (context) => const AdminDashboardScreen(),         // لوحة تحكم الإدارة لمراجعة الحسابات
      },
    );
  }
}
