import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';

class StreamsGuideStep extends StatelessWidget {
  final int number;
  final String text;

  const StreamsGuideStep({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: theme.btnColor2,
            child: Text(
              '$number',
              style: TextStyle(color: theme.btnTextColor, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(text, style: theme.defaultTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
