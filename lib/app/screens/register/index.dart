import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class RegisterIndex extends StatefulWidget {
  const RegisterIndex({super.key});

  @override
  State<RegisterIndex> createState() => _RegisterIndexState();
}

class _RegisterIndexState extends State<RegisterIndex> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/register.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Inscrivez-vous à FitPulse",
                style: TextStyle(
                  color: AppColors.blueSea,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Input(
              label: "Pseudo",
              placeholder: "example",
            ),
            const SizedBox(height: 20),
            Input(
              label: "Mail",
              placeholder: "example@domain.com",
            ),
            const SizedBox(height: 20),
            Input(
              label: "Mot de passe",
              placeholder: "**********",
              obscure: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => GoRouter.of(context)
                  .pushReplacementNamed('session.index'), //_googleLogin
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteTitanium,
                backgroundColor: AppColors.blueSea,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Valider l\'inscription',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Déjà un compte ?'),
            TextButton(
              onPressed: () =>
                  GoRouter.of(context).pushReplacementNamed('login.index'),
              child: Text(
                'Connectez-vous !',
                style: TextStyle(
                  color: AppColors.blueSea,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
