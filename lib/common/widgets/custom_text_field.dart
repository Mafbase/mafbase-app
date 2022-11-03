import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seating_generator_web/app/assets.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class CustomTextField extends StatefulWidget {
  final Widget? icon;
  final TextEditingController controller;
  final bool canObscure;
  final String? errorText;
  final Widget? suffixIcon;
  final String? hint;
  final bool isRequiredField;
  final double bottomPadding;
  final Function(String s)? onSubmit;
  final FocusNode? focusNode;
  final TextInputType? textInputType;

  const CustomTextField({
    Key? key,
    this.icon,
    this.textInputType,
    required this.controller,
    this.suffixIcon,
    this.hint,
    this.onSubmit,
    this.errorText,
    this.focusNode,
    this.bottomPadding = 10,
    this.canObscure = false,
    this.isRequiredField = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool obscureText = widget.canObscure;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsets.only(
                right: 24,
              ),
              child: widget.icon!,
            ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: TextFormField(
                    keyboardType: widget.textInputType,
                    onFieldSubmitted: widget.onSubmit,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      suffixIcon: widget.suffixIcon,
                      errorText: widget.errorText,
                      errorMaxLines: 1,
                      hintText: widget.hint,
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(widget.canObscure) IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                            color: MyTheme.of(context).borderColor,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        SvgPicture.asset(AppAssets.exclamationPoint, height: 18,),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
