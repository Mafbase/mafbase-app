import 'package:flutter/material.dart';

sealed class TournamentMenuItemModel {
  final String text;
  final IconData icon;

  const TournamentMenuItemModel({
    required this.text,
    required this.icon,
  });
}

class TournamentMenuTapItem extends TournamentMenuItemModel {
  final VoidCallback onTap;
  final String? routeSegment;
  final bool selected;
  final String? trailingText;

  const TournamentMenuTapItem({
    required super.text,
    required super.icon,
    required this.onTap,
    this.routeSegment,
    this.selected = false,
    this.trailingText,
  });
}

class TournamentMenuExpandableItem extends TournamentMenuItemModel {
  final Widget Function(VoidCallback onCollapse) contentBuilder;

  const TournamentMenuExpandableItem({
    required super.text,
    required super.icon,
    required this.contentBuilder,
  });
}

/// Пункт функции, которая ещё не оплачена: не выделяется и не меняет маршрут, тап только вызывает [onTap].
class TournamentMenuLockedItem extends TournamentMenuItemModel {
  final String hint;
  final VoidCallback onTap;

  const TournamentMenuLockedItem({
    required super.text,
    required super.icon,
    required this.hint,
    required this.onTap,
  });
}

class TournamentMenuSection {
  final String title;
  final List<TournamentMenuItemModel> items;

  const TournamentMenuSection({
    required this.title,
    required this.items,
  });
}
