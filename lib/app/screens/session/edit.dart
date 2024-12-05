import 'package:fitpulse_app/data/providers/session.dart';
// import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SessionEdit extends StatelessWidget {
  final String id;

  const SessionEdit({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // var theme = Provider.of<ThemeProvider>(context);
    var session = Provider.of<SessionProvider>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Modifier la séance',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       foregroundColor: AppColors.whiteTitanium,
              //       backgroundColor: theme.color,
              //       padding:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              //     ),
              //     child: const Text(
              //       'Modifier la séance',
              //       style: TextStyle(fontSize: 16),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      int idInt = int.parse(id);
                      session.destroy(idInt);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Impossible de supprimer la séance.')),
                      );
                    }
                    GoRouter.of(context).goNamed('session.index');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.whiteTitanium,
                    backgroundColor: AppColors.redLava,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                  ),
                  child: const Text(
                    'Supprimer la séance',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
