import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/data/providers/session.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
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

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final session = Provider.of<SessionProvider>(context, listen: false);
      /*session.store(
        Exercise(
          category: 'PERSO',
          isTime: isTime,
          name: name,
          recovery: Duration(seconds: recovery),
          sessions: sessions,
          nb: isTime ? null : nb,
          time: isTime ? Duration(seconds: time) : null,
        ),
      );*/

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Séance créée avec succès!')),
      );
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

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
                      'Ajouter un séance',
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

    /*return Container(
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
          *//*const Input(
            label: 'Nom de la séance',
            placeholder: "Muscles abdominaux",
          ),*//*
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
                'Valider la séance',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );*/
  }
}
