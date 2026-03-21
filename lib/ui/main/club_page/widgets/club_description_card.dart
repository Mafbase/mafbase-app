import 'package:flutter/material.dart';
import 'package:seating_generator_web/utils.dart';

class ClubDescriptionCard extends StatelessWidget {
  final String? description;
  final VoidCallback? onEditDescription;

  const ClubDescriptionCard({
    super.key,
    required this.description,
    this.onEditDescription,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.background2,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.cardShadowColor,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
            child: Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 18,
                  color: theme.darkBlueColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    context.locale.description,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.darkBlueColor,
                    ),
                  ),
                ),
                if (onEditDescription != null)
                  IconButton(
                    onPressed: onEditDescription,
                    icon: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: theme.darkGreyColor,
                    ),
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              description?.isNotEmpty == true ? description! : context.locale.clubDescriptionEmpty,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: description?.isNotEmpty == true ? theme.darkGreyColor : theme.hintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
