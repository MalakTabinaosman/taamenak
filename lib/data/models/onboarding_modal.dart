// ========================================================
// نموذج صفحات التعريف بالبرنامج (OnboardingModel)
// يحتوي على الصور والنصوص التوضيحية التي تظهر للمستخدم الجديد
// ========================================================
class OnboardingModel {
  /// مسار صورة التوضيح من مجلد assets
  final String imagePath;

  /// عنوان الصفحة التوضيحية
  final String title;

  /// الشرح المفصل للميزة
  final String description;

  const OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  /// قائمة الصفحات التوضيحية الثابتة
  static const List<OnboardingModel> onboardingList = [
    OnboardingModel(
      imagePath: "assets/onboarding/onboarding1.png",
      title: "احجز طبيبك ببساطة",
      description: "احجز مواعيد بسهولة مع أفضل الأطباء والمستشفيات الشريكة ضمن شبكة تأمينك الطبية.",
    ),
    OnboardingModel(
      imagePath: "assets/onboarding/onboarding2.png",
      title: "صور الروشتة بضغطة زر",
      description: "التقط صورة للروشتة الطبية وسنقوم بتحليلها فورًا لمعرفة الأدوية المطلوبة.",
    ),
  ];
}
