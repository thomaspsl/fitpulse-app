import 'package:fitpulse_app/data/providers/exercise.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExerciseEdit extends StatefulWidget {
  final String id;

  const ExerciseEdit({super.key, required this.id});

  @override
  State<ExerciseEdit> createState() => _ExerciseEditState();
}

class _ExerciseEditState extends State<ExerciseEdit> {
  void _submitUpdate(BuildContext context, String id) {
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    GoRouter router = GoRouter.of(context);

    router.pop();
    messenger.showSnackBar(
      SnackBar(
          backgroundColor: AppColors.redLava,
          content: Text('Fonctionnalité indisponible.')),
    );
  }

  void _submitDestroy(BuildContext context, String id) {
    ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    ExerciseProvider exerciseProvider = Provider.of(context);
    GoRouter router = GoRouter.of(context);

    try {
      int idInt = int.parse(id);
      exerciseProvider.destroy(idInt);
      router.pop();
      messenger.showSnackBar(
        SnackBar(
            backgroundColor: AppColors.greenMint,
            content: Text('Exercice supprimé.')),
      );
    } catch (e) {
      router.pop();
      messenger.showSnackBar(
        SnackBar(
            backgroundColor: AppColors.redLava,
            content: Text('Erreur de suppression.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);


    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Modifier un exercice',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitUpdate(context, widget.id),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.whiteTitanium,
                    backgroundColor: themeProvider.color,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  ),
                  child: const Text(
                    'Modifier l\'exercice',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitDestroy(context, widget.id),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.whiteTitanium,
                    backgroundColor: AppColors.redLava,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                  ),
                  child: const Text(
                    'Supprimer l\'exercice',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
