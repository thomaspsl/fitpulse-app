import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

abstract class Controller extends StatelessWidget {
  const Controller({super.key});

  static String getCurrentPath(BuildContext context) {
    try {
      final router = GoRouter.of(context);
      final Uri currentUri = router.routeInformationProvider.value.uri;
      return currentUri.toString();
    } catch (e) {
      debugPrint("Erreur lors de la récupération du chemin de la route : $e");
      return "/"; 
    }
  }
}