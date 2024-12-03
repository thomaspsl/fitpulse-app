import 'package:flutter/material.dart';

class SessionCreate extends StatelessWidget {
  const SessionCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          children: const [
            Text('Ajout d\'une séance'),
          ],
        ),
      ),
    );
  }
}
