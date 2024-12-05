import 'package:fitpulse_app/data/providers/exercise.dart';
import 'package:fitpulse_app/data/providers/session.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/data/providers/user.dart';
import 'package:fitpulse_app/data/providers/date.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
        ChangeNotifierProvider<SessionProvider>(create: (context) => SessionProvider()),
        ChangeNotifierProvider<ExerciseProvider>(create: (context) => ExerciseProvider()),
        ChangeNotifierProvider<DateProvider>(create: (context) => DateProvider()),
      ],
      child: App(),
    ),
  );
}
