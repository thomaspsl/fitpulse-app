import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExerciseIndex extends StatelessWidget {
  const ExerciseIndex({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).color;

    final sections = [
      {
        'title': 'Vos exercices',
        'items': List.generate(6, (index) => 'Exo n°$index'),
      },
      {
        'title': 'Exercices de muscu',
        'items': List.generate(8, (index) => 'Exo n°$index'),
      },
      {
        'title': 'Exercices de cadio',
        'items': List.generate(10, (index) => 'Exo n°$index'),
      },
      {
        'title': 'Exercices de ???',
        'items': List.generate(10, (index) => 'Exo n°$index'),
      },
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: sections.map((section) {
            final title = section['title'] as String;
            final items = section['items'] as List<String>;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, itemIndex) {
                        final itemName = items[itemIndex];
                        return Container(
                          margin: const EdgeInsets.only(right: 8.0),
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                              colors: [color, color.withOpacity(0.5)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              itemName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
