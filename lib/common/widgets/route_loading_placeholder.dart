import 'package:material_ui/material_ui.dart';

/// Индикатор загрузки на месте страницы, пока роутер подгружает её deferred-часть.
class RouteLoadingPlaceholder extends StatelessWidget {
  const RouteLoadingPlaceholder({super.key});

  static Widget builder(BuildContext context) => const RouteLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
