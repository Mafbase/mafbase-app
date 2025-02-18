import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final double? value;

  const LoadingOverlayWidget({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.alphaBlend(
        MyTheme.of(context).background1,
        Colors.black.withOpacity(0.1),
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: value,
        ),
      ),
    );
  }
}
