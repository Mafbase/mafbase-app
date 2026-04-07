import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/ui/app_shell/app_sidebar.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

@RoutePage()
class AppShellPage extends StatefulWidget {
  const AppShellPage({super.key});

  @override
  State<AppShellPage> createState() => _AppShellState();
}

class _AppShellState extends CustomState<AppShellPage> {
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
