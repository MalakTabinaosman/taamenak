import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taamenak/data/models/onboarding_modal.dart';
import 'package:taamenak/ui/signup/sign_up.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }

  void _onNextPressed(int itemsCount) async {
    if (_currentIndex < itemsCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await _finishOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int itemsCount = OnboardingModel.onboardingList.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header: Back & Skip Buttons
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                /*  IconButton(
                    iconSize: 18,
                    onPressed: _currentIndex > 1
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back_ios),
                    color: _currentIndex > 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),*/
                  TextButton(
                    onPressed: () async {
                      // عند الضغط على تخطي، يتم حفظ الحالة والانتقال مباشرة
                      await _finishOnboarding();
                    },
                    child: Text(
                      "تخطي",
                      style: Theme.of(context).textTheme.labelLarge!
                          .copyWith(color: Theme.of(context).disabledColor),
                    ),
                  ),
                ],
              ),
            ),

            // PageView Builder لعرض صور الـ Onboarding
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: itemsCount,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final onboardingItem = OnboardingModel.onboardingList[index];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withAlpha(15),
                        ),
                        child: Image.asset(
                          onboardingItem.imagePath,
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.width * 0.55,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                },
              ),
            ),

            // Bottom Container: Titles, Indicators, & Action Button
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF0F4F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    OnboardingModel.onboardingList[_currentIndex].title,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    OnboardingModel.onboardingList[_currentIndex].description,
                    style: Theme.of(context).textTheme.bodyMedium!
                        .copyWith(color: Colors.grey.shade700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: itemsCount,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                      expansionFactor: 3.5,
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Theme.of(context).disabledColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Button (Next / Get Started)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () => _onNextPressed(itemsCount),
                      child: Text(
                        _currentIndex == itemsCount - 1
                            ? 'ابدأ الآن'
                            : 'التالي',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
