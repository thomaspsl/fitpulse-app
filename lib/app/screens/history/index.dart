import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:fitpulse_app/app/config/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HistoryIndex extends StatelessWidget {
  const HistoryIndex({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);

    final List<String> historyItems = List.generate(20, (index) => 'Historique Item ${index + 1}');

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Historique',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Correction: Expanded cannot be used inside a SingleChildScrollView
              ListView.builder(
                shrinkWrap: true, // Allows ListView to be inside a SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemCount: historyItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [theme.color, theme.color.withOpacity(0.5)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      leading: const Icon(Icons.history, color: AppColors.whiteTitanium),
                      title: Text(
                        historyItems[index],
                        style: const TextStyle(color: AppColors.whiteTitanium),
                      ),
                      subtitle: Text(
                        'Description de l\'élément ${index + 1}',
                        style: const TextStyle(color: AppColors.whiteTitanium),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.whiteTitanium),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
