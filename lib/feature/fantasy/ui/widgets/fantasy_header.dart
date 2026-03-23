import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyHeader extends StatelessWidget {
  final FantasyState state;
  final VoidCallback? onParticipantsPressed;
  final Widget? trailing;

  const FantasyHeader({
    super.key,
    required this.state,
    this.onParticipantsPressed,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Spacer(),
          Text(
            context.locale.fantasy,
            style: MyTheme.of(context).headerTextStyle,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onParticipantsPressed != null)
                  IconButton(
                    onPressed: onParticipantsPressed,
                    icon: const Icon(Icons.people),
                    tooltip: context.locale.fantasyParticipants,
                  ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
