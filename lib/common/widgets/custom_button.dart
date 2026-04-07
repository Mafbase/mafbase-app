import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool disabled;
  final bool isRed;
  final bool minimize;
  final bool expand;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isRed = false,
    this.disabled = false,
    this.minimize = false,
    this.expand = true,
    this.isLoading = false,
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

            return isRed ? theme.btnRedColor : theme.darkBlueColor;
          },
        ),
      ),
      onPressed: disabled ? null : onTap,
      child: expand
          ? Center(
              child: isLoading
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        textWidget,
                        SizedBox(
                          width: minimize ? 16 : 20,
                          height: minimize ? 16 : 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: MyTheme.of(context).btnTextStyle.color,
                          ),
                        ),
                      ],
                    )
                  : textWidget,
            )
          : isLoading
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    textWidget,
                    SizedBox(
                      width: minimize ? 16 : 20,
                      height: minimize ? 16 : 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: MyTheme.of(context).btnTextStyle.color,
                      ),
                    ),
                  ],
                )
              : textWidget,
    );
  }
}
