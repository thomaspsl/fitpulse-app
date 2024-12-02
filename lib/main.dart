import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/data/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
      ],
      child: App(),
    ),
  );
}