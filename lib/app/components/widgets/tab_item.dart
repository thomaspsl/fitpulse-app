import 'package:flutter/cupertino.dart';

class TabItem extends BottomNavigationBarItem {
  final String url;

  const TabItem({
    required this.url,
    required super.icon,
    required Widget super.activeIcon,
    super.label
  });
}