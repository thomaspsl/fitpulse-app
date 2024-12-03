import 'package:fitpulse_app/data/models/user.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/data/providers/user.dart';
import 'package:fitpulse_app/data/services/db_helper.dart';
import 'package:fitpulse_app/data/services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp();
  await NotificationsService().init();

  final dbHelper = DBHelper();
  final db = await dbHelper.database;
  //await dbHelper.deleteDatabase();

  /*// Initialisation de la base de données et test des fonctionnalités
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

  /*final userProvider = UserProvider();

// Ajouter un utilisateur
  final newUser = User(
    name: 'John Doe',
    email: 'johndoe@example.com',
    password: 'password123',
    color: Color(0xFF0000FF),
  );
  await userProvider.store(newUser);

// Ajouter un commentaire
  await userProvider.addCommentForUser(
    userId: newUser.id!,
    content: 'Ceci est un commentaire pour John Doe.',
  );

// Vérifier les commentaires de l'utilisateur
  final comments = await userProvider.getCommentsForUser(newUser.id!);
  print('Commentaires pour l\'utilisateur : $comments');*/


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
        // ChangeNotifierProvider<ExerciseProvider>(create: (context) => ExerciseProvider()),
        // ChangeNotifierProvider<SessionProvider>(create: (context) => SessionProvider()),
        // ChangeNotifierProvider<DateProvider>(create: (context) => DateProvider()),
      ],
      child: App(), // db: db
    ),
  );
}
