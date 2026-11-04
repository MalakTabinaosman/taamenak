import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taamenak/core/theme/app_colors.dart';
import 'package:taamenak/core/theme/app_theme.dart';
import 'package:taamenak/splash_screen.dart';
import 'package:taamenak/ui/login/login.dart';
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
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}