import 'package:flutter/material.dart';

class ExerciceIndex extends StatelessWidget {
  const ExerciceIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(25),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child:
                Text(
                  'Séance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
