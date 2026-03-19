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

  const TournamentMenuTapItem({
    required super.text,
    required super.icon,
    required this.onTap,
    this.routeSegment,
    this.selected = false,
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

class TournamentMenuSection {
  final String title;
  final List<TournamentMenuItemModel> items;

  const TournamentMenuSection({
    required this.title,
    required this.items,
  });
}
