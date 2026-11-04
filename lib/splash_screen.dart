import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:taamenak/ui/onboarding/onboarding.dart';
import 'package:taamenak/ui/signup/sign_up.dart';

class SplashPage extends StatelessWidget {
  final bool seenOnboarding;

  const SplashPage({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logoWidth: MediaQuery.of(context).size.width * 0.9,
      showLoader: false,
      logo: Image.asset('assets/images/logo.png'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      navigator: OnboardingScreen.routeName,
      durationInSeconds: 3,
    );
  }
}
