import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class Mapper extends ColorMapper {
  final Color c;

  const Mapper({required this.c});

  @override
  Color substitute(
      String? id, String elementName, String attributeName, Color color) {
    if (['change1', 'change2'].contains(id)) return c;
    return color;
  }
}
