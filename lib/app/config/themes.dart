import 'package:fitpulse_app/app/config/colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  // ThemeData Light Mode
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: AppColors.greyLight,
    ),
    scaffoldBackgroundColor: AppColors.whiteTitanium,
    primaryColor: AppColors.blackCoal,
    cardColor: AppColors.greyDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );

  // ThemeData Dark Mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: AppColors.greyDark,
    ),
    scaffoldBackgroundColor: AppColors.blackCoal,
    primaryColor: AppColors.whiteTitanium,
    cardColor: AppColors.greyLight,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
