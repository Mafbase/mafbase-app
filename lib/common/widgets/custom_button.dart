import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool disabled;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 57,
        decoration: BoxDecoration(
          color: disabled
              ? MyTheme.of(context).btnColor2
              : MyTheme.of(context).btnColor1,
        ),
        child: Center(
          child: Text(
            text,
            style: MyTheme.of(context).btnTextStyle,
          ),
        ),
      ),
    );
  }
}
