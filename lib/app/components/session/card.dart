import 'package:fitpulse_app/app/config/colors.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SessionCard extends StatelessWidget {
  final dynamic session;
  final int index;
  final ThemeProvider theme;

  const SessionCard({
    super.key,
    required this.session,
    required this.index,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(
        'session.edit',
        pathParameters: {'id': "$index"},
      ),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [theme.color, theme.color.withValues(alpha: 0.5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              session.type.toString().split('.').last,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.whiteTitanium.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
            Text(
              session.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.whiteTitanium,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Icon(
              Icons.timer,
              color: AppColors.whiteTitanium.withValues(alpha: 0.7),
              size: 20,
            ),
            const SizedBox(height: 5),
            Text(
              "Récup : ${session.recovery}s",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.whiteTitanium.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
