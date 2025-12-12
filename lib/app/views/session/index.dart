import 'package:fitpulse_app/app/components/session/category.dart';
import 'package:fitpulse_app/data/providers/session.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SessionIndex extends StatelessWidget {
  const SessionIndex({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var sessions = Provider.of<SessionProvider>(context).sessions;

    final Map<String, String> categoryTitles = {
      'PERSO': 'Vos séances',
      'MUSCU': 'Séances de muscu',
      'CARDIO': 'Séances de cardio',
      'AUTRES': 'Autres séances',
    };

    final groupedSessions = _groupSessions(sessions, categoryTitles);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: groupedSessions.entries
                .where((entry) => entry.value.isNotEmpty)
                .map((entry) {
              return SessionCategory(
                title: categoryTitles[entry.key]!,
                sessions: entry.value,
                theme: theme,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Map<String, List<dynamic>> _groupSessions(
      List<dynamic> sessions,
      Map<String, String> categoryTitles,
      ) {
    final Map<String, List<dynamic>> groupedSessions = {'AUTRES': []};

    for (var i = 0; i < sessions.length; i++) {
      final session = sessions[i];
      final category = session.category;

      if (categoryTitles.containsKey(category)) {
        groupedSessions.putIfAbsent(category, () => []);
        groupedSessions[category]!.add({'session': session, 'index': i});
      } else {
        groupedSessions['AUTRES']!.add({'session': session, 'index': i});
      }
    }

    return groupedSessions;
  }
}
