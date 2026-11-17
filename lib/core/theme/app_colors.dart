import 'dart:ui';

// ========================================================
// واجهة لوحة الألوان الأساسية للتطبيق (AppColors Contract)
// تحدد جميع درجات الألوان المطلوبة للهوية البصرية
// ========================================================
abstract class AppColors {
  Brightness get brightness;

  /// اللون الرئيسي للهوية (الأزرق الداكن للعلامة التجارية)
  Color get mainColor;

  /// لون النصوص والعناوين الرئيسية
  Color get mainTextColor;

  /// لون الخلفيات والشاشات
  Color get backgroundColor;

  /// لون نصوص وحقول الإدخال
  Color get inputColor;

  /// لون العناصر غير المفعلة أو الرمادية
  Color get disableColor;

  /// لون الحدود والإطارات (Borders / Strokes)
  Color get strokeColor;

  /// لون النصوص الفرعية والتوضيحية
  Color get secondaryTextColor;

  /// لون رسائل وأزرار الخطأ والتحذيرات
  Color get errorColor;
}

// ========================================================
// الثيم الفاتح (Light Mode Colors Palette)
// تطبيق الألوان الفاتحة لهوية "تأمينك"
// ========================================================
class LightColors extends AppColors {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get mainColor => const Color(0xFF074E7C); // الأزرق الطبي المعتمد

  @override
  Color get mainTextColor => const Color(0xFF1D1F54); // الكحلي الداكن للعناوين

  @override
  Color get secondaryTextColor => const Color(0xFF2A2A37); // الرمادي الغامق للنصوص

  @override
  Color get backgroundColor => const Color(0xFFFFFFFF); // الخلفية البيضاء النقية

  @override
  Color get inputColor => const Color(0xFF000000); // لون مدخلات المستخدم

  @override
  Color get strokeColor => const Color(0xFF074E7C); // حدود الحقول والأزرار

  @override
  Color get disableColor => const Color(0xFFB1B1B1); // لون الحقول المعطلة

  @override
  Color get errorColor => const Color(0xFFE53935); // اللون الأحمر للتنبيهات والأخطاء
}
