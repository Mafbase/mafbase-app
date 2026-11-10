import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Отступ сверху и заголовки AppBar слева для iPhone Duo, где статус-бар — капсула сбоку, а сверху отступа нет.
/// Обход https://github.com/flutter/flutter/issues/193202: убрать, когда Flutter научится этой раскладке сам.
class SideStatusBarAdapter extends StatelessWidget {
  static const topInset = 20.0;

  final Widget child;

  const SideStatusBarAdapter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.iOS) return child;

    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final viewPadding = mediaQuery.viewPadding;
    final isSideStatusBar = viewPadding.top == 0 && (viewPadding.left > 0) != (viewPadding.right > 0);

    // Обёртка одна и та же в любой раскладке: если форма дерева поменяется, Flutter при повороте
    // или складывании пересоздаст навигатор со всеми страницами.
    return MediaQuery(
      data: isSideStatusBar
          ? mediaQuery.copyWith(
              padding: mediaQuery.padding.copyWith(top: mediaQuery.padding.top + topInset),
              viewPadding: viewPadding.copyWith(top: viewPadding.top + topInset),
            )
          : mediaQuery,
      child: Theme(
        data: isSideStatusBar ? theme.copyWith(appBarTheme: theme.appBarTheme.copyWith(centerTitle: false)) : theme,
        child: child,
      ),
    );
  }
}
