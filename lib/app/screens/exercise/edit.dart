import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/app/components/widgets/toggle.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExerciseEdit extends StatelessWidget {
  final String id;

  const ExerciseEdit({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Modifier un exercice : $id',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Input(
            label: 'Nom de l\'exercice',
            placeholder: "Planche",
          ),
          const SizedBox(height: 10),
          Toggle(
            label: "Type :",
            options: const ["Temps", "Répétitions"],
            initialSelectedOption: null,
            onOptionSelected: (selectedOption) {
              print("Option sélectionnée : $selectedOption");
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteTitanium,
                backgroundColor: theme.color,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Modifier l\'exercice',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
