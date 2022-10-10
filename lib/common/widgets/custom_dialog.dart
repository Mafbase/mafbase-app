import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final Widget child;

  const CustomDialog({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          widget.child,
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
