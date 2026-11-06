import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class NotificationCoverageUnreachableRow extends StatelessWidget {
  final String nickname;
  final String reason;
  final VoidCallback? onSetFsmNickname;

  const NotificationCoverageUnreachableRow({
    super.key,
    required this.nickname,
    required this.reason,
    this.onSetFsmNickname,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isMobile = context.isMobile;

    return Padding(
      padding: EdgeInsets.fromLTRB(isMobile ? 16 : 20, 6, 8, 10),
      child: Row(
        children: [
          Icon(Icons.notifications_off_outlined, size: 20, color: theme.darkGreyColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          nickname,
                          style: theme.defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (onSetFsmNickname case final onTap?)
                        TextButton(
                          onPressed: onTap,
                          style: TextButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            textStyle: theme.defaultTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          child: Text(context.locale.checklistCoverageSetFsmNickname),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(reason, style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.darkGreyColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
