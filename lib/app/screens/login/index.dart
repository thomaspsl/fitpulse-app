import 'package:fitpulse_app/app/components/widgets/input.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitpulse_app/data/services/auth_service.dart';

class LoginIndex extends StatefulWidget {
  const LoginIndex({super.key});

  @override
  State<LoginIndex> createState() => _LoginIndexState();
}


class _LoginIndexState extends State<LoginIndex> {
  final AuthService _authService = AuthService();
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
              'lib/assets/images/login.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Connectez-vous à FitPulse",
                style: TextStyle(
                  color: AppColors.blueSea,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
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
              onPressed: () => GoRouter.of(context).pushReplacementNamed('session.index'), //_googleLogin
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteTitanium,
                backgroundColor: AppColors.blueSea,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Valider la connexion',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _authService.signInWithGoogle();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Connexion réussie !')),
                  );
                  GoRouter.of(context).pushReplacementNamed('session.index');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur de connexion : $e')),
                  );
                }
              },
              child: Text('Se connecter avec Google'),
            ),
            const SizedBox(height: 20),
            const Text('Vous découvrez FitPulse ?'),
            TextButton(
              onPressed: () => GoRouter.of(context).pushReplacementNamed('register.index'),
              child: Text(
                'Inscrivez-vous',
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
