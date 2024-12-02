import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  void setTheme(Color color) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.setTheme(color);
  }

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).color;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Choisir une couleur'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: color,
                                onColorChanged: setTheme,
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Valider'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Choisir une couleur'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}