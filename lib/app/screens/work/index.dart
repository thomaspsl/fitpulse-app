import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:flutter/material.dart';

class SessionDetailsIndex extends StatelessWidget {
  final String sessionName;

  const SessionDetailsIndex({
    Key? key,
    required this.sessionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la séance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom de la séance :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              sessionName,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Type de séance :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Exercices :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            /*Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.fitness_center, color: Colors.blue),
                      title: Text(
                        exercise.name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        exercise.isTime
                            ? 'Durée : ${exercise.time?.inSeconds}s | Récupération : ${exercise.recovery.inSeconds}s'
                            : 'Répétitions : ${exercise.nb} | Récupération : ${exercise.recovery.inSeconds}s',
                        style: TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        // Action lorsqu'un exercice est sélectionné
                        print('Exercice sélectionné : ${exercise.name}');
                      },
                    ),
                  );
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
