import 'package:fitpulse_app/app/config/colors.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  Color _color = AppColors.blueSea; // Prendre celui en base

  Color get color => _color;

  Future<void> update(Color color) async {
    _color = color;
    notifyListeners();
  }
}