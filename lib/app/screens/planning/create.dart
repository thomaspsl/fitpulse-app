import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PlanningCreate extends StatefulWidget {
  const PlanningCreate({super.key});

  @override
  State<PlanningCreate> createState() => _PlanningCreateState();
}

class _PlanningCreateState extends State<PlanningCreate> {
  final _formKey = GlobalKey<FormState>();

  // Variables

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Séance planifiée avec succès!')),
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
                      'Planifier une séance',
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
                        'Planifier la séance',
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
