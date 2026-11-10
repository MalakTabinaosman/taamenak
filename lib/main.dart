import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taamenak/core/theme/app_colors.dart';
import 'package:taamenak/core/theme/app_theme.dart';
import 'package:taamenak/splash_screen.dart';
import 'package:taamenak/ui/home/tabs/appointments.dart';
import 'package:taamenak/ui/home/tabs/booking_tab.dart';
import 'package:taamenak/ui/home/tabs/prescription_tab.dart';
import 'package:taamenak/ui/home/buttom_navigation_bar.dart';
import 'package:taamenak/ui/login/login.dart';
import 'package:taamenak/ui/home/tabs/profile_tab.dart';
import 'package:taamenak/ui/signup/sign_up.dart';
import 'package:taamenak/ui/onboarding/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ntolepkkqqnbkpqzykxb.supabase.co',
    publishableKey: 'sb_publishable_lrUfevG2ijXa0SshUiqW8A_rb-nV12V',
  );

  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;*/

  runApp(MyApp(seenOnboarding: false));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme(LightColors()).theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(seenOnboarding: false),
        '/booking': (context) => const BookingTab(),
        '/prescriptions': (context) => const PrescriptionTab(),
        '/appointments': (context) => const AppointmentsTab(),
        '/profile': (context) => const ProfileTab(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}