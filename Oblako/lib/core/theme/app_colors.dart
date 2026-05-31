import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryPrimaryValue = 0xFFFFB901;

  static const MaterialColor primary = MaterialColor(
    _primaryPrimaryValue,
    <int, Color>{
      50: Color(0xFFFFF4D9),
      100: Color(0xFFFFE8B3),
      200: Color(0xFFFFDB8C),
      300: Color(0xFFFFCF66),
      400: Color(0xFFFFC742),
      500: Color(_primaryPrimaryValue),
      600: Color(0xFFE6A501),
      700: Color(0xFFCC9201),
      800: Color(0xFFB38001),
      900: Color(0xFF805E01),
    },
  );

  static const Color secondary = Color(0xFF2B7DE9);

  static const Color bgColors = Color(0xFFF6F6F5);

  static const Color lightGrey = Color(0xFFE0E0E0);

  static const onBackground = Color(0xFF000000);
}
