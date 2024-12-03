import 'package:flutter/material.dart';

class ExerciseCreate extends StatelessWidget {
  const ExerciseCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          children: const [

            Text('Ajout d\'un exercice'),
          ],
        ),
      ),
    );
  }
}
