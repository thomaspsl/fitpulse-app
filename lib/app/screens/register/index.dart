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
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                // controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Mail',
                  labelStyle: const TextStyle(color: Color(0xFF777777)),
                  filled: true,
                  fillColor: const Color(0xFFEBE9E9),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                // controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: const TextStyle(color: Color(0xFF777777)),
                  filled: true,
                  fillColor: const Color(0xFFEBE9E9),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => GoRouter.of(context)
                  .pushReplacementNamed('seance.index'), //_googleLogin
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'Valider l\'inscription',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {}, //_googleLogin
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Theme.of(context).indicatorColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              ),
              child: const Text(
                'S\'inscrire avec Google',
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
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
