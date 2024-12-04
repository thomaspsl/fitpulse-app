import 'package:fitpulse_app/app/config/colors.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PlanningCreate extends StatelessWidget {
  const PlanningCreate({super.key});

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
          const Center(
            child: Text(
              'Planifier une séance',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteTitanium,
                backgroundColor: theme.color,
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Planifier la séance',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
