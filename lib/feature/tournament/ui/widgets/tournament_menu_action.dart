import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class TournamentMenuAction extends StatelessWidget {
  final VoidCallback openDrawer;

  const TournamentMenuAction({
    super.key,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.isMobile) return const SizedBox.shrink();

    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: openDrawer,
    );
  }
}
