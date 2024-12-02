import 'package:fitpulse_app/app/routes/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Color _color = AppColors.blueSea; // Prendre celui en base
  Color get color => _color;

  void setTheme(Color color) {
    _color = color;
    notifyListeners();
  }
}