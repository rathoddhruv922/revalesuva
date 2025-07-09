import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color brand = Color(0xFFE7B5B7);

  // Text Colors
  static const Color textPrimary = Color(0xFF101010);
  static const Color textSecondary = Color(0xFF5A5B5D);
  static const Color textTertiary = Color(0xFFFFFFFF);
  static const Color textError = Color(0xFFCE4E4E);

  // Icons Colors
  static const Color iconPrimary = Color(0xFF101010);
  static const Color iconSecondary = Color(0xFF5A5B5D);
  static const Color iconTertiary = Color(0xFFFFFFFF);
  static const Color iconGreen = Color(0xFF7DAA84);
  static const Color iconRed = Color(0xFFCE4E4E);

  // Border Colors
  static const Color borderPrimary = Color(0xFF101010);
  static const Color borderSecondary = Color(0xFF5A5B5D);
  static const Color borderTertiary = Color(0xFFE0E0E0);
  static const Color borderBrand = Color(0xFFE7B5B7);
  static const Color borderGreen = Color(0xFF7DAA84);
  static const Color borderBlurDark = Color(0xFF16285A);
  static const Color borderLightGray = Color(0xFFE0E0E0);

  // Surface Colors
  static const Color surfacePrimary = Color(0xFFF5EADD);
  static const Color surfaceSecondary = Color(0xFFFAF5EF);
  static const Color surfaceTertiary = Color(0xFFFFFFFF);
  static const Color surfaceQuadruple = Color(0xFFE0E0E0);
  static const Color surfacePurpleLight = Color(0xFFC8AECC);
  static const Color surfacePurple = Color(0xFF896592);
  static const Color surfaceGreen = Color(0xFF7DAA84);
  static const Color surfaceGreenDark = Color(0xFF98B2AE);
  static const Color surfaceGreenLight = Color(0xFFAAC9B3);
  static const Color surfaceOrange = Color(0xFFF0AE6C);
  static const Color surfaceYellow = Color(0xFFFDE89E);
  static const Color surfaceBlueDark = Color(0xFF16285A);
  static const Color surfaceBlue = Color(0xFF46AEC6);
  static const Color surfaceBlueLight = Color(0xFFB3D9EC);
  static const Color surfaceBlueGrey = Color(0xFFC6D1DC);
  static const Color surfaceError = Color(0xFFCE4E4E);
  static const Color surfaceBrand = Color(0xFFE7B5B7);

  //shadow color
  static Color shadowColor = const Color(0xFF666666).withValues(alpha: 0.19);
  static Color lightGray = surfaceQuadruple;

  //orderStatus
  static const Color pending = Color(0xFFFFFFE0);
  static const Color processing = Color(0xFFADD8E6);
  static const Color shipped = Color(0xFF90EE90);
  static const Color delivered = Color(0xFFE0FFFF);
  static const Color canceled = Color(0xFFF08080);
  static const Color returned = Color(0xFFFFA07A);
  static const Color refunded = Color(0xFFFFB6C1);
}
