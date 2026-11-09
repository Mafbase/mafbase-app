import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class OrganizerChecklistGroupSection extends StatelessWidget {
  final String title;
  final Widget? action;
  final List<Widget> children;

  const OrganizerChecklistGroupSection({
    super.key,
    required this.title,
    required this.children,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              if (action case final action?) action,
            ],
          ),
        ),
        ...children,
      ],
    );
  }
}

class OrganizerChecklistSubheader extends StatelessWidget {
  final String text;

  const OrganizerChecklistSubheader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 4),
      child: Text(
        text,
        style: theme.defaultTextStyle.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: theme.darkGreyColor,
        ),
      ),
    );
  }
}
