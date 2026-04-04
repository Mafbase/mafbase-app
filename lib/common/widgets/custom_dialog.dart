import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;

  const CustomDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 24,
      ),
      child: child,
    );
  }
}
