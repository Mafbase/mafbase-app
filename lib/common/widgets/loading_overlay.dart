import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final double? value;

  const LoadingOverlayWidget({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: CircularProgressIndicator(
          value: value,
        ),
      ),
    );
  }
}
