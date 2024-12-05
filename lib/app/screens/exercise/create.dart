import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/data/providers/exercise.dart';
import 'package:fitpulse_app/data/models/exercise.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ExerciseCreate extends StatefulWidget {
  const ExerciseCreate({super.key});

  @override
  State<ExerciseCreate> createState() => _ExerciseCreateState();
}

class _ExerciseCreateState extends State<ExerciseCreate> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  bool isTime = true;
  int time = 30;
  int nb = 10;
  int sessions = 3;
  int recovery = 60;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final exercise = Provider.of<ExerciseProvider>(context, listen: false);
      exercise.store(
        Exercise(
          category: 'PERSO',
          isTime: isTime,
          name: name,
          recovery: Duration(seconds: recovery),
          sessions: sessions,
          nb: isTime ? null : nb,
          time: isTime ? Duration(seconds: time) : null,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exercice créé avec succès!')),
      );
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

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
                      'Ajouter un exercice',
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
                          label: 'Nom de l\'exercice',
                          hintText: 'Planche',
                          initialValue: name,
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
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Type: ',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            ChoiceChip(
                              label: const Text('Temps'),
                              selected: isTime,
                              selectedColor: theme.color,
                              onSelected: (bool selected) {
                                setState(() {
                                  isTime = selected;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            ChoiceChip(
                              label: const Text('Répétitions'),
                              selected: !isTime,
                              selectedColor: theme.color,
                              onSelected: (bool selected) {
                                setState(() {
                                  isTime = !selected;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (isTime)
                          Input(
                            key: GlobalKey(),
                            label: 'Temps (secondes)',
                            hintText: '30',
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            initialValue: time.toString(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer une durée';
                              }
                              final intValue = int.tryParse(value);
                              if (intValue == null || intValue < 1 || intValue > 300) {
                                return 'Veuillez entrer une valeur entre 1 et 300';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                time = int.tryParse(value) ?? 30;
                              });
                            },
                          )
                        else
                          Input(
                            key: GlobalKey(),
                            label: 'Répétitions',
                            hintText: '10',
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            initialValue: nb.toString(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un nombre de répétitions';
                              }
                              final intValue = int.tryParse(value);
                              if (intValue == null || intValue < 1 || intValue > 100) {
                                return 'Veuillez entrer une valeur entre 1 et 100';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                nb = int.tryParse(value) ?? 10;
                              });
                            },
                          ),
                        const SizedBox(height: 10),
                        Input(
                          label: 'Nombre de séries',
                          hintText: '3',
                          keyboardType: TextInputType.numberWithOptions(signed: true),
                          initialValue: sessions.toString(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer un nombre de séries';
                            }
                            final intValue = int.tryParse(value);
                            if (intValue == null || intValue < 1 || intValue > 10) {
                              return 'Veuillez entrer une valeur entre 1 et 10';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              sessions = int.tryParse(value) ?? 3;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Input(
                          label: 'Pause entre séries (secondes)',
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
                              recovery = int.tryParse(value) ?? 60;
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
                        'Valider l\'exercice',
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