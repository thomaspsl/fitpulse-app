import 'package:fitpulse_app/app/routes/router.dart';
import 'package:fitpulse_app/app/routes/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppColors.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}