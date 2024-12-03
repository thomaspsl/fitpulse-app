import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SessionCreate extends StatelessWidget {
  const SessionCreate({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).color;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Ajouter une séance',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Input(
            label: 'Nom de la séance',
            placeholder: "Muscles abdominaux",
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: color,
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Valider la séance',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
