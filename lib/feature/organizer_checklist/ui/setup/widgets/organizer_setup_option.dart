import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

/// Вариант ответа в мастере настройки: нажатие сразу переводит на следующий шаг.
class OrganizerSetupOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String hint;
  final VoidCallback onTap;

  const OrganizerSetupOption({
    super.key,
    required this.icon,
    required this.title,
    required this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Material(
      color: theme.background2,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: theme.darkGreyColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      hint,
                      style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.darkGreyColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: theme.hintColor),
            ],
          ),
        ),
      ),
    );
  }
}
