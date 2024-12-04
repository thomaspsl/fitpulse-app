import 'package:fitpulse_app/app/config/colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  // ThemeData Light Mode
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.whiteTitanium,
    primaryColor: AppColors.blackCoal,
    cardColor: AppColors.greyDark,
    indicatorColor: AppColors.greyLight,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );

  // ThemeData Dark Mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blackCoal,
    primaryColor: AppColors.whiteTitanium,
    cardColor: AppColors.greyLight,
    indicatorColor: AppColors.greyDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
