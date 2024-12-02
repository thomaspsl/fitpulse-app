import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/data/providers/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fitpulse_app/data/services/seance_service.dart';
import 'package:fitpulse_app/data/models/seance.dart';
import 'app.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de la base de données et test des fonctionnalités
  final seanceService = SeanceService();

  // Ajouter une séance de test
  final newSeance = Seance(
    nom: 'Renforcement musculaire',
    type: 'Cardio',
    date: '2023-12-05 18:00',
    notification: 15,
  );
  await seanceService.addSeance(newSeance);

  // Lire toutes les séances pour vérifier l'insertion
  final seances = await seanceService.getSeances();
  print('Séances après insertion : $seances');*/

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
