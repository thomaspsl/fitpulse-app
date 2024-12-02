import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class SvgColorMapper extends ColorMapper {
  final Color svgColor;

  const SvgColorMapper({required this.svgColor});

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color
  ) {
    if (['change1', 'change2'].contains(id)) return svgColor;
    return color;
  }
}
