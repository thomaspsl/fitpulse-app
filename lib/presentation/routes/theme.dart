import 'package:flutter/material.dart';

abstract class AppColors {
  // Global reference to application colors
  static const whiteTitanium = Color(0xFFFFFFFF);
  static const greyLight = Color(0xFF999999);
  static const greyDark = Color(0xFF333333);
  static const blackCoal = Color(0xFF101010);
  static const yellowSun = Color(0xFFFFD700);
  static const blueSea = Color(0xFF00BFA5);
  static const redLava = Color(0xFFFD4601);
  static const greenMint = Color(0xFF66AC52);

  // ThemeData Light Mode
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: whiteTitanium,
    primaryColor: blueSea,
    cardColor: greyDark,
    indicatorColor: greyLight,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  // ThemeData Dark Mode
/*  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: blackCoal,
    primaryColor: whiteTitanium,
    cardColor: greyLight,
    indicatorColor: greyDark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );*/
}
