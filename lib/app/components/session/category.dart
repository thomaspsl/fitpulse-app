import 'package:fitpulse_app/app/components/session/card.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:flutter/material.dart';

class SessionCategory extends StatelessWidget {
  final String title;
  final List<dynamic> sessions;
  final ThemeProvider theme;

  const SessionCategory({
    super.key,
    required this.title,
    required this.sessions,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final item = sessions[index];
                return SessionCard(
                  session: item['session'],
                  index: item['index'],
                  theme: theme,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            ),
          ),
        ],
      ),
    );
  }
}
