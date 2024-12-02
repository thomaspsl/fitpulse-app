import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  final String url;

  const ScaffoldWithNavBarTabItem({
    required this.url,
    required super.icon,
    required Widget super.activeIcon,
    super.label,
  });
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    var color = Provider.of<ThemeProvider>(context).color;

    // List of routes
    List<ScaffoldWithNavBarTabItem> tabs = [
      const ScaffoldWithNavBarTabItem(
        url: '/',
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Accueil',
      ),
      const ScaffoldWithNavBarTabItem(
        url: '/seance',
        icon: Icon(Icons.sports_football_outlined),
        activeIcon: Icon(Icons.sports_football),
        label: 'Séance',
      ),
      ScaffoldWithNavBarTabItem(
        url: '/seance/create',
        icon: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).indicatorColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add_rounded,
            size: 35,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        activeIcon: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add_rounded,
            size: 35,
            color: Theme.of(context).scaffoldBackgroundColor
          ),
        ),
        label: '',
      ),
      const ScaffoldWithNavBarTabItem(
        url: '/plannifieur',
        icon: Icon(Icons.task_outlined),
        activeIcon: Icon(Icons.task),
        label: 'Plannifieur',
      ),
      const ScaffoldWithNavBarTabItem(
        url: '/planning',
        icon: Icon(Icons.calendar_today_outlined),
        activeIcon: Icon(Icons.calendar_today),
        label: 'Planning',
      ),
    ];

    // On Selection
    void onItemTapped(int index, int selectedIndex) {
      if (index != selectedIndex) {
        setState(() => selectedIndex = index);
        context.go(tabs[index].url);
      }
    }

    // Check the current index
    int selectedIndex = tabs.indexWhere(
      (tab) => tab.url == GoRouterState.of(context).uri.toString(),
    );

    return BottomNavigationBar(
      iconSize: 30,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: color,
      unselectedItemColor: Theme.of(context).indicatorColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex == -1 ? 0 : selectedIndex,
      onTap: (index) => onItemTapped(index, selectedIndex),
      items: tabs,
    );
  }
}