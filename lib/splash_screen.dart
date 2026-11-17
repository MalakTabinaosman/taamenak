import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:taamenak/ui/onboarding/onboarding.dart';

// ========================================================
// شاشة البداية (Splash Screen)
// تعرض شعار التطبيق (Logo) لعدة ثوانٍ عند الفتح ثم تنقل المستخدم
// ========================================================
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      // عرض الشعار ليمثل 90% من عرض الشاشة
      logoWidth: MediaQuery.of(context).size.width * 0.9,

      // إخفاء مؤشر التحميل الدائري والاكتفاء بالشعار
      showLoader: false,

      // صورة الشعار من مجلد الـ assets
      logo: Image.asset('assets/images/logo.png'),

      // لون الخلفية مأخوذ من ثيم التطبيق
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // الشاشة التي يتم الانتقال إليها بعد انتهاء الوقت
      navigator: OnboardingScreen.routeName,

      // مدة ظهور الشاشة (3 ثوانٍ)
      durationInSeconds: 3,
    );
  }
}
