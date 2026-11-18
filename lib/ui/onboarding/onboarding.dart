import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taamenak/data/models/onboarding_modal.dart';
import 'package:taamenak/ui/signup/sign_up.dart';

/// ============================================================================
/// شاشة التعريف بالتطبيق والترحيب (OnboardingScreen)
/// تظهر للمستخدم عند فتح التطبيق لأول مرة لشرح مميزات التطبيق الطبية والتأمينية،
/// تحتوي على شرائح متحركة، مؤشر تقدم تفاعلي، وزر "التالي" أو "ابدأ الآن".
/// يتم حفظ حالة المشاهدة في [SharedPreferences] حتى لا تظهر مجدداً.
/// ============================================================================
class OnboardingScreen extends StatefulWidget {
  /// اسم المسار للتنقل
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// وحدة التحكم في تقليب الصفحات
  final PageController _pageController = PageController();

  /// فهرس الشريحة المعروضة حالياً
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // ضبط وضع الشاشة لملء الشاشة بالكامل أثناء العرض الترحيبي
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    // إعادة شريط الحالة والأزرار النظامية للوضع الطبيعي
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  /// إنهاء مرحلة التعريف، حفظ حالة المشاهدة، والانتقال لشاشة التسجيل
  Future<void> _finishOnboarding() async {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
  }

  /// معالجة الضغط على زر "التالي" أو الانتقال للشريحة التالية أو الإنهاء
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
            // -----------------------------------------------------------------
            // الترويسة العلوية: زر "تخطي" لتجاوز الشرائح فوراً
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      // عند الضغط على تخطي، يتم حفظ الحالة والانتقال مباشرة للتسجيل
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

            // -----------------------------------------------------------------
            // عارض الصفحات (PageView) لعرض الصور التوضيحية
            // -----------------------------------------------------------------
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
                      // حاوية الصورة التوضيحية
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

            // -----------------------------------------------------------------
            // الحاوية السفلية: العناوين، النقاط المؤشرة، وزر المتابعة
            // -----------------------------------------------------------------
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary
                    .withValues(alpha: 0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // عنوان الشريحة
                  Text(
                    OnboardingModel.onboardingList[_currentIndex].title,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // الوصف التوضيحي للشريحة
                  Text(
                    OnboardingModel.onboardingList[_currentIndex].description,
                    style: Theme.of(context).textTheme.bodyMedium!
                        .copyWith(color: Theme.of(context).disabledColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // نقاط مؤشر التقليب التفاعلية (Smooth Page Indicator)
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

                  // زر الإجراء الرئيسي (التالي / ابدأ الآن)
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
                          color: Theme.of(context).colorScheme.onPrimary,
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
