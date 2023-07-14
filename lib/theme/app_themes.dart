import 'package:calculator/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  // light theme
  static ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.workSansTextTheme(),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onBackgroundColor,
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.onBackgroundColor,
      primaryContainer: AppColors.containerColor,
      error: Colors.red,
      onError: AppColors.onBackgroundColor,
      background: AppColors.backgroundColor,
      onBackground: AppColors.onBackgroundColor,
      surface: AppColors.backgroundColor,
      onSurface: AppColors.onBackgroundColor,
    ),
  );

  // dark theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.workSansTextTheme(),
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onBackgroundDarkColor,
      secondary: AppColors.secondaryDarkColor,
      onSecondary: AppColors.onBackgroundDarkColor,
      primaryContainer: AppColors.containerDarkColor,
      error: Colors.red,
      onError: AppColors.onBackgroundDarkColor,
      background: AppColors.backgroundDarkColor,
      onBackground: AppColors.onBackgroundDarkColor,
      surface: AppColors.backgroundDarkColor,
      onSurface: AppColors.onBackgroundDarkColor,
    ),
  );
}
