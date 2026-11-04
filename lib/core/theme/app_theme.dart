import 'package:flutter/material.dart';
import 'package:taamenak/core/theme/app_colors.dart';

class AppTheme {
  AppColors appColors;

  AppTheme(this.appColors);

  ThemeData get theme => ThemeData(
    colorScheme: ColorScheme(
      brightness: appColors.brightness,
      primary: appColors.mainColor,
      onPrimary: appColors.inputColor,
      secondary: appColors.mainTextColor,
      onSecondary: appColors.inputColor,
      error: appColors.errorColor,
      onError: appColors.inputColor,
      surface: appColors.backgroundColor,
      onSurface: appColors.mainColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: appColors.backgroundColor,
      foregroundColor: appColors.mainTextColor,
      centerTitle: true,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
    scaffoldBackgroundColor: appColors.backgroundColor,
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: appColors.backgroundColor,
      contentPadding: EdgeInsets.all(16),
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
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.all(16),
        minimumSize: Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(16),
        minimumSize: Size(double.infinity, 56),
        backgroundColor: appColors.mainColor.withAlpha(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(fontSize: 16, fontWeight: .bold),
        foregroundColor: appColors.mainColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appColors.backgroundColor,
      selectedItemColor: appColors.mainColor,
      unselectedItemColor: appColors.mainTextColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    ),
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
  );
}
