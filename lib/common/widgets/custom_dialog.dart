import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;

  const CustomDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(
        left: 40,
        right: 40,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: child,
    );
  }
}
