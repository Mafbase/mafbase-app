import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class CustomTextField extends StatefulWidget {
  final Widget? icon;
  final TextEditingController controller;
  final bool canObscure;
  final String? errorText;
  final String? hint;
  final Function(String s)? onSubmit;
  final FocusNode? focusNode;

  const CustomTextField({
    Key? key,
    this.icon,
    required this.controller,
    this.hint,
    this.onSubmit,
    this.errorText,
    this.focusNode,
    this.canObscure = false,
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
                    onFieldSubmitted: widget.onSubmit,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      errorText: widget.errorText,
                      hintText: widget.hint,
                      border: const UnderlineInputBorder(),
                    ),
                  ),
                ),
                if (widget.canObscure)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: IconButton(
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
