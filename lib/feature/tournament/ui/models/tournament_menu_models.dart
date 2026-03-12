import 'package:flutter/material.dart';

class TournamentMenuItemModel {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final String? routeSegment;
  final bool selected;

  const TournamentMenuItemModel({
    required this.text,
    required this.icon,
    required this.onTap,
    this.routeSegment,
    this.selected = false,
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
