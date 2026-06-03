import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.background,
    hintColor: AppColors.textInverse,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 11,
        fontWeight: FontWeight.w300,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    dividerColor: AppColors.divider,
  );
}

/// TextStyle extensions for ease
extension AppTextStyles on BuildContext {
  TextStyle get extraBold => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get bold => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get semiBold => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get medium => Theme.of(this).textTheme.titleLarge!;
  TextStyle get regular => Theme.of(this).textTheme.titleMedium!;
  TextStyle get light => Theme.of(this).textTheme.titleSmall!;
}
