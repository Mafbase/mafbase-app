import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

/// Плашка справа от названия пункта меню; шрифт задаёт само меню.
class TournamentMenuTrailingText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const TournamentMenuTrailingText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: context.theme.sidebarActiveItemBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: style),
    );
  }
}
