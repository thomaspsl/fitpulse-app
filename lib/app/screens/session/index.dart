import 'package:fitpulse_app/data/providers/session.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:go_router/go_router.dart';
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

    final Map<String, List<dynamic>> groupedSessions = {
      'AUTRES': [],
    };

    for (var i = 0; i < sessions.length; i++) {
      final session = sessions[i];
      final category = session.category;;

      if (categoryTitles.containsKey(category)) {
        if (!groupedSessions.containsKey(category)) {
          groupedSessions[category] = [];
        }
        groupedSessions[category]!.add({'session': session, 'index': i});
      } else {
        groupedSessions['AUTRES']!.add({'session': session, 'index': i});
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: groupedSessions.entries
                .where((entry) => entry.value.isNotEmpty)
                .map((entry) {
              final categorySessions = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        categoryTitles[entry.key]!,
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
                        itemCount: categorySessions.length,
                        itemBuilder: (context, index) {
                          final item = categorySessions[index];
                          final session = item['session'];

                          return GestureDetector(
                            onTap: () => GoRouter.of(context).pushNamed(
                              'session.edit',
                              pathParameters: {'id': "${item['index']}"},
                            ),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [theme.color, theme.color.withOpacity(0.5)],
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
                                      color: AppColors.whiteTitanium
                                          .withOpacity(0.7),
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
                                    color: AppColors.whiteTitanium
                                        .withOpacity(0.7),
                                    size: 20,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Récup : ${session.recovery}s",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.whiteTitanium
                                          .withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 8);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
