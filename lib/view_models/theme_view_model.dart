import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revalesuva/utils/app_colors.dart';
import 'package:revalesuva/utils/app_corner.dart';
import 'package:revalesuva/utils/app_font_size.dart';

class ThemeViewModel extends GetxController {
  var themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    super.onInit();
    updateTheme(isLight: true, isIceBlue: false);
  }

  getTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surfacePrimary,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: AppFontSize.displayLarge,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
          fontSize: AppFontSize.displayMedium,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          fontSize: AppFontSize.displaySmall,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          fontSize: AppFontSize.headingLarge,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontSize: AppFontSize.headingMedium,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontSize: AppFontSize.headingSmall,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          fontSize: AppFontSize.titleLarge,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          fontSize: AppFontSize.titleMedium,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          fontSize: AppFontSize.titleSmall,
          fontWeight: FontWeight.w600,
        ),
        labelLarge: TextStyle(
          fontSize: AppFontSize.labelLarge,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: AppFontSize.labelMedium,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppFontSize.labelSmall,
        ),
        bodyLarge: TextStyle(
          fontSize: AppFontSize.bodyLarge,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          fontSize: AppFontSize.bodyMedium,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          fontSize: AppFontSize.bodySmall,
          fontWeight: FontWeight.normal,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        textStyle: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontSize: AppFontSize.bodySmall,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      )),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surfaceBrand,
          foregroundColor: AppColors.iconPrimary,
          side: const BorderSide(color: AppColors.surfaceBrand, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppCorner.button),
          ),
          textStyle: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: AppFontSize.labelMedium,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  updateTheme({required bool isLight, required bool isIceBlue}) {
    if (isIceBlue) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.surfaceBlue, // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColors.surfaceGreen, // navigation bar color, the one Im looking for
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
    themeMode.value = ThemeMode.light;
  }
}
