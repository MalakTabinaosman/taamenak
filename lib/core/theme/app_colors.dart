import 'package:flutter/material.dart';

abstract class AppColors {
  Brightness get brightness;

  Color get mainColor;

  Color get mainTextColor;

  Color get backgroundColor;

  Color get inputColor;

  Color get disableColor;

  Color get strokeColor;

  Color get secondaryTextColor;

  Color get errorColor;
}

class LightColors extends AppColors {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get mainColor => const Color(0xFF074E7C);

  @override
  Color get mainTextColor => const Color(0xFF1D1F54); 

  @override
  Color get secondaryTextColor => const Color(0xFF2A2A37); 
  @override
  Color get backgroundColor => const Color(0xFFFFFFFF); 

  @override
  Color get inputColor => const Color(0xFF000000); 
  @override
  Color get strokeColor => const Color(0xFF074E7C); 

  @override
  Color get disableColor => const Color(0xFFB1B1B1);

  @override
  Color get errorColor => const Color(0xFFE53935);
}
