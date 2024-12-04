import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileIndex extends StatelessWidget {
  const ProfileIndex({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.account_circle_rounded,
              color: theme.color,
              size: 100,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    var newTheme = Provider.of<ThemeProvider>(context);

                    return AlertDialog(
                      title: const Text('Choisir une couleur'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: newTheme.color,
                          onColorChanged: theme.update,
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => GoRouter.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.whiteTitanium,
                            backgroundColor: theme.color,
                            padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                          ),
                          child: const Text('Valider'),
                        ),
                      ],
                    );
                  },
                )
              }, //_googleLogin
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteTitanium,
                backgroundColor: theme.color,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Choisir une couleur',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).goNamed('login.index'), //_googleLogin
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteTitanium,
                backgroundColor: AppColors.redLava,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Se déconnecter',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
