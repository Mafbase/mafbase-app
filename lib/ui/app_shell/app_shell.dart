import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/ui/app_shell/app_sidebar.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class AppShell extends StatefulWidget {
  const AppShell({super.key});

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
          const Expanded(child: AutoRouter()),
        ],
      ),
    );
  }

  @override
  Widget? buildMobile(BuildContext context) => const AutoRouter();
}
