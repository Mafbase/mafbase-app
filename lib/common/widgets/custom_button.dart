import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool disabled;
  final bool isRed;
  final bool minimize;
  final bool expand;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isRed = false,
    this.disabled = false,
    this.minimize = false,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    final textWidget = Text(
      text,
      style: theme.btnTextStyle.copyWith(
        fontSize: minimize ? 15 : 18,
      ),
      textAlign: TextAlign.center,
    );

    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(
          Size(0, minimize ? 40 : 48),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: minimize ? 20 : 32),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return theme.buttonDisabledColor;
            }
            if (states.contains(WidgetState.pressed)) {
              return isRed ? theme.btnRedColor1 : theme.btnColor1;
            }
            return isRed ? theme.btnRedColor : theme.darkGreyColor;
          },
        ),
      ),
      onPressed: disabled ? null : onTap,
      child: expand ? Center(child: textWidget) : textWidget,
    );
  }
}
