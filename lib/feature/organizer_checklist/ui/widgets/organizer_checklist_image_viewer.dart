import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

/// Скриншот справки на весь экран: его можно увеличить жестом или колесом мыши.
class OrganizerChecklistImageViewer extends StatelessWidget {
  final String asset;

  const OrganizerChecklistImageViewer({super.key, required this.asset});

  static Future<void> show(BuildContext context, {required String asset}) => showDialog<void>(
        context: context,
        useSafeArea: false,
        builder: (_) => OrganizerChecklistImageViewer(asset: asset),
      );

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Dialog.fullscreen(
      backgroundColor: theme.background1,
      child: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              maxScale: 6,
              child: Center(child: Image.asset(asset, excludeFromSemantics: true)),
            ),
          ),
          PositionedDirectional(
            top: 0,
            end: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: theme.background2, shape: BoxShape.circle),
                  child: const CloseButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
