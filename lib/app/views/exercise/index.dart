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

    final Map<String, List<Map<String, dynamic>>> groupedExercises = {
      'AUTRES': [],
    };

    for (var i = 0; i < exercises.length; i++) {
      final exercise = exercises[i];
      final category = exercise.category;

      if (categoryTitles.containsKey(category)) {
        if (!groupedExercises.containsKey(category)) {
          groupedExercises[category] = [];
        }
        groupedExercises[category]!.add({'exercise': exercise, 'index': i});
      } else {
        groupedExercises['AUTRES']!.add({'exercise': exercise, 'index': i});
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(),
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
                          final item = categoryExercises[index];
                          final exercise = item['exercise'];

                          return GestureDetector(
                            onTap: () => GoRouter.of(context).pushNamed(
                              'exercise.edit',
                              pathParameters: {'id': "${item['index']}"},
                            ),
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
                                  if (exercise.isTime)
                                    Text(
                                      "Temps : ${exercise.time.inSeconds}s",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.whiteTitanium.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    )
                                  else
                                    Text(
                                      "Séries : ${exercise.nb}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.whiteTitanium.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                  const SizedBox(height: 5),
                                  Icon(
                                    Icons.timer,
                                    color: AppColors.whiteTitanium.withOpacity(0.7),
                                    size: 20,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Récup : ${exercise.recovery.inSeconds }s",
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
