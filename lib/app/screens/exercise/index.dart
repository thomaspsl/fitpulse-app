import 'package:fitpulse_app/app/screens/exercise/edit.dart';
import 'package:fitpulse_app/data/providers/exercise.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExerciseIndex extends StatelessWidget {
  const ExerciseIndex({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var exercises = Provider.of<ExerciseProvider>(context).exercises;

    final Map<String, String> categoryTitles = {
      'PERSO': 'Vos exercices',
      'MUSCU': 'Exercices de muscu',
      'CARDIO': 'Exercices de cardio',
      'AUTRES': 'Autres exercices',
    };

    final Map<String, List<dynamic>> groupedExercises = {
      'AUTRES': [],
    };

    for (var exercise in exercises) {
      final category = exercise.category;
      if (categoryTitles.containsKey(category)) {
        if (!groupedExercises.containsKey(category)) {
          groupedExercises[category] = [];
        }
        groupedExercises[category]!.add(exercise);
      } else {
        groupedExercises['AUTRES']!.add(exercise);
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: groupedExercises.entries
                .where((entry) => entry.value.isNotEmpty)
                .map((entry) {
              final categoryExercises = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        categoryTitles[entry.key]!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryExercises.length,
                        itemBuilder: (context, index) {
                          final exercise = categoryExercises[index];
                          return GestureDetector(
                            onTap: () => GoRouter.of(context).pushNamed(
                                'exercise.edit',
                                pathParameters: {'id': "${exercise.id}"}),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [theme.color.withOpacity(0.5), theme.color],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    exercise.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColors.whiteTitanium,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Icon(
                                    Icons.timer,
                                    color: AppColors.whiteTitanium
                                        .withOpacity(0.7),
                                    size: 20,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Récup : ${exercise.recovery}s",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.whiteTitanium
                                          .withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 8);
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
