import 'package:flutter/material.dart';
import 'package:taamenak/core/theme/app_colors.dart';

/// ============================================================================
/// كلاس الثيم العام للتطبيق (AppTheme)
/// يقوم بتوليد [ThemeData] بناءً على ألوان [AppColors] المحددة (مثل LightColors)
/// ويوحد تنسيق الخطوط، الحقول، الأزرار، والبطاقات على مستوى التطبيق بالكامل.
/// ============================================================================
class AppTheme {
  /// كائن الألوان المستخدم لتخصيص الثيم
  final AppColors appColors;

  AppTheme(this.appColors);

  /// إرجاع كائن ThemeData الكامل والمخصص للتطبيق
  ThemeData get theme => ThemeData(
    // -------------------------------------------------------------------------
    // نظام الألوان العام (ColorScheme)
    // -------------------------------------------------------------------------
    colorScheme: ColorScheme(
      brightness: appColors.brightness,
      primary: appColors.mainColor, // اللون الأساسي (الأخضر/الفيروزي الطبي)
      onPrimary: Colors.white, // لون العناصر على اللون الأساسي
      secondary: appColors.mainTextColor, // اللون الثانوي
      onSecondary: Colors.white,
      error: appColors.errorColor, // لون الأخطاء والتنبيهات
      onError: Colors.white,
      surface: appColors.backgroundColor, // لون الخلفيات والأسطح
      onSurface: appColors.mainTextColor, // لون النصوص على الأسطح
    ),
    primaryColor: appColors.mainColor,
    disabledColor: appColors.disableColor,

    // -------------------------------------------------------------------------
    // ثيم شريط التطبيق العلوي (AppBar)
    // -------------------------------------------------------------------------
    appBarTheme: AppBarTheme(
      backgroundColor: appColors.backgroundColor,
      foregroundColor: appColors.mainTextColor,
      centerTitle: true,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
    scaffoldBackgroundColor: appColors.backgroundColor,

    // -------------------------------------------------------------------------
    // ثيم حقول الإدخال والنصوص (Input Fields)
    // -------------------------------------------------------------------------
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: appColors.backgroundColor,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      prefixIconColor: appColors.mainTextColor,
      suffixIconColor: appColors.mainTextColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 1, color: appColors.strokeColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 1, color: appColors.strokeColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 1, color: appColors.strokeColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 1, color: appColors.errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 1, color: appColors.errorColor),
      ),
    ),

    // -------------------------------------------------------------------------
    // ثيم الأزرار المعبأة (Filled Buttons)
    // -------------------------------------------------------------------------
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white,
      ),
    ),

    // -------------------------------------------------------------------------
    // ثيم الأزرار المرتفعة (Elevated Buttons)
    // -------------------------------------------------------------------------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors.mainColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // -------------------------------------------------------------------------
    // ثيم رسائل التنبيه العائمة (SnackBar)
    // -------------------------------------------------------------------------
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: appColors.mainColor,
      contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // -------------------------------------------------------------------------
    // ثيم الأزرار ذات الإطار الخارجي (Outlined Buttons)
    // -------------------------------------------------------------------------
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: appColors.mainColor.withAlpha(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        foregroundColor: appColors.mainColor,
      ),
    ),

    // -------------------------------------------------------------------------
    // ثيم شريط التنقل السفلي (Bottom Navigation Bar)
    // -------------------------------------------------------------------------
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appColors.backgroundColor,
      selectedItemColor: appColors.mainColor,
      unselectedItemColor: appColors.mainTextColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),

    // -------------------------------------------------------------------------
    // ثيم النصوص وأحجام الخطوط (Text Theme)
    // -------------------------------------------------------------------------
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      displayMedium: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      displaySmall: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineLarge: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineSmall: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleMedium: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      titleSmall: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        color: appColors.mainTextColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        color: appColors.mainTextColor,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: appColors.mainTextColor,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        color: appColors.mainTextColor,
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    ),

    // -------------------------------------------------------------------------
    // ثيم البطاقات العامة (Cards)
    // -------------------------------------------------------------------------
    cardTheme: CardThemeData(
      color: appColors.backgroundColor,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    // -------------------------------------------------------------------------
    // ثيم الشرائح والعلامات (Chips)
    // -------------------------------------------------------------------------
    chipTheme: ChipThemeData(
      backgroundColor: appColors.backgroundColor,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      labelStyle: TextStyle(
        color: appColors.mainTextColor,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),

    // -------------------------------------------------------------------------
    // ثيم الخطوط الفاصلة (Dividers)
    // -------------------------------------------------------------------------
    dividerTheme: DividerThemeData(
      color: appColors.strokeColor,
      thickness: 1,
      space: 1,
    ),
  );
}
