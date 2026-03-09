import 'package:flutter/material.dart';
import 'package:seating_generator_web/ui/app_shell/app_sidebar.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class AppShell extends StatefulWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends CustomState<AppShell> {
  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AppSidebar(),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  @override
  Widget? buildMobile(BuildContext context) => widget.child;
}
