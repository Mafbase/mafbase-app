import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool disabled;
  final bool isRed;
  final bool minimize;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isRed = false,
    this.disabled = false,
    this.minimize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWidget = Column(
      children: [
        const Spacer(),
        Text(
          text,
          style: MyTheme.of(context).btnTextStyle,
        ),
        const Spacer(),
      ],
    );
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return MyTheme.of(context).buttonDisabledColor;
            }
            if (states.contains(MaterialState.pressed)) {
              if (isRed) {
                return MyTheme.of(context).btnRedColor1;
              } else {
                return MyTheme.of(context).btnColor1;
              }
            }
            if (isRed) {
              return MyTheme.of(context).btnRedColor;
            } else {
              return MyTheme.of(context).darkGreyColor;
            }
          },
        ),
      ),
      onPressed: disabled ? null : onTap,
      child: SizedBox(
        height: 57,
        child: minimize ? textWidget : Center(child: textWidget),
      ),
    );
  }
}
