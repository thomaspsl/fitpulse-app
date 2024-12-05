import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/data/providers/session.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:fitpulse_app/data/models/session.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SessionCreate extends StatefulWidget {
  const SessionCreate({super.key});

  @override
  State<SessionCreate> createState() => _SessionCreateState();
}

class _SessionCreateState extends State<SessionCreate> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  List<Exercise> selectedExercises = [];
  SessionType? type;
  int recovery = 60;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate() && selectedExercises.isNotEmpty) {
      final session = Provider.of<SessionProvider>(context, listen: false);
      /*session.store(
        Session(
          name: name,
          exercises: selectedExercises,
          type: type,
          category: 'PERSO',
          recovery: restBetweenExercises.inSeconds,
        ),
      );*/

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Séance créée avec succès!')),
      );
      GoRouter.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez compléter tous les champs.')),
      );
    }
  }

  /*void _showLinkForm(BuildContext context, List<Exercise> exercisesProvider, List<Exercise> selectedExercises, Function(List<Exercise>) onUpdate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gérer les exercices'),
          content: SingleChildScrollView(
            child: Column(
              children: exercisesProvider.map((exercise) {
                final isSelected = selectedExercises.contains(exercise);
                return CheckboxListTile(
                  title: Text(exercise.name),
                  value: isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedExercises.add(exercise);
                      } else {
                        selectedExercises.remove(exercise);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                onUpdate(selectedExercises);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    // var exercisesProvider = Provider.of<Exercise>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 1,
      minChildSize: 0.6,
      snap: true,
      expand: false,
      snapSizes: [0.7],
      builder: (context, scrollController) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(Icons.drag_handle, color: Colors.grey),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                controller: scrollController,
                children: [
                  const Center(
                    child: Text(
                      'Ajouter une séance',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Input(
                          label: 'Nom de la séance',
                          hintText: 'Dos',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer un nom';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.whiteTitanium,
                              backgroundColor: theme.color,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                            ),
                            child: const Text(
                              'Gérer les exercices',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        /*ElevatedButton(
                          onPressed: () => {},
                          onPressed: () => _showAddExercisesToSessionForm(
                              context,
                              exercisesProvider,
                              selectedExercises,
                                  (updatedExercises) {
                                setState(() {
                                  selectedExercises = updatedExercises;
                                });
                              }),
                          child: const Text('Gérer les exercices'),
                        ),*/
                        const SizedBox(height: 10),
                        Text('Exercices ajoutés: ${selectedExercises.length}'),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Type:',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: SessionType.values.map((sessionType) {
                                final isSelected = type == sessionType;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: ChoiceChip(
                                    label: Text(
                                      sessionType.toString().split('.').last,
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.whiteTitanium
                                            : AppColors.blackCoal,
                                      ),
                                    ),
                                    checkmarkColor: AppColors.whiteTitanium,
                                    selected: isSelected,
                                    selectedColor: theme.color,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        type = selected ? sessionType : null;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        /*DropdownButtonFormField<SessionType>(
                          value: type,
                          onChanged: (SessionType? newValue) {
                            setState(() {
                              type = newValue!;
                            });
                          },
                          items: SessionType.values.map((SessionType sessionType) {
                            return DropdownMenuItem<SessionType>(
                              value: sessionType,
                              child: Text(sessionType.toString().split('.').last),
                            );
                          }).toList(),
                        ),*/
                        const SizedBox(height: 20),
                        Input(
                          label: 'Pause entre exercices (secondes)',
                          hintText: '60',
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          initialValue: recovery.toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer une durée de pause';
                            }
                            final intValue = int.tryParse(value);
                            if (intValue == null || intValue < 0 || intValue > 300) {
                              return 'Veuillez entrer une valeur entre 0 et 300';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              recovery = int.tryParse(value) ?? 3;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _submitForm(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.whiteTitanium,
                        backgroundColor: theme.color,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 25),
                      ),
                      child: const Text(
                        'Valider la séance',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
