import 'package:fitpulse_app/app/components/widgets/tab_item.dart';
import 'package:fitpulse_app/app/config/controller.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final bool hide;

  const Footer({super.key, this.hide = false});

  @override
  Widget build(BuildContext context) {
    if (hide) return const SizedBox.shrink();

    var theme = Provider.of<ThemeProvider>(context);
    var currentPath = Controller.getCurrentPath(context);

    // List of routes
    final List<TabItem> tabs = [
      const TabItem(
        url: '/',
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Accueil',
      ),
      const TabItem(
        url: '/exercise',
        icon: Icon(Icons.sports_football_outlined),
        activeIcon: Icon(Icons.sports_football),
        label: 'Exercices',
      ),
      const TabItem(
        url: '/planning',
        icon: Icon(Icons.calendar_today_outlined),
        activeIcon: Icon(Icons.calendar_today),
        label: 'Planning',
      ),
      const TabItem(
        url: '/history',
        icon: Icon(Icons.task_outlined),
        activeIcon: Icon(Icons.task),
        label: 'Historique',
      ),
    ];

    // Determine the selected index based on the current route
    int selectedIndex = tabs.indexWhere((tab) => tab.url == currentPath);

    // On tap action for BottomNavigationBar
    void onItemTapped(int index) {
      if (selectedIndex != index) {
        GoRouter.of(context).go(tabs[index].url);
      }
    }

    return BottomNavigationBar(
      iconSize: 30,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: theme.color,
      unselectedItemColor: Theme.of(context).cardColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
      onTap: onItemTapped,
      items: tabs.map((tab) {
        return BottomNavigationBarItem(
          icon: tab.icon,
          activeIcon: tab.activeIcon,
          label: tab.label,
        );
      }).toList(),
    );
  }
}
