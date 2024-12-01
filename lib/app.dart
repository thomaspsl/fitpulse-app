import 'package:fitpulse_app/presentation/routes/router.dart';
import 'package:fitpulse_app/presentation/routes/theme.dart';
import 'package:fitpulse_app/presentation/screens/profile/index.dart';
import 'package:fitpulse_app/presentation/screens/programme/index.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppColors.lightTheme,
      /*darkTheme: AppColors.darkTheme,*/
      routerConfig: AppRouter.router,
      /*routes: {
        '/': (context) => ProgrammeIndex(),
        '/profile': (context) => ProfileIndex(),
      }*/
    );
  }
}