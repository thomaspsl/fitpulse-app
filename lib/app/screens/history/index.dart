import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HistoryIndex extends StatelessWidget {
  const HistoryIndex({super.key});

  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).color;
    final List<String> historyItems = List.generate(20, (index) => 'Historique Item ${index + 1}');

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Historique',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.5)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.history, color: AppColors.whiteTitanium),
                    title: Text(historyItems[index], style: TextStyle(color: AppColors.whiteTitanium),),
                    subtitle: Text('Description de l\'élément ${index + 1}', style: TextStyle(color: AppColors.whiteTitanium)),
                    trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.whiteTitanium),
                    onTap: () {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //  SnackBar(content: Text('Vous avez cliqué sur ${historyItems[index]}')),
                      // );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
