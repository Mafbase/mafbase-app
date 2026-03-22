import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';
import 'package:seating_generator_web/ui/main/club_page/widgets/club_action_card.dart';
import 'package:seating_generator_web/utils.dart';

class ClubActionsSection extends StatelessWidget {
  final bool isOwner;
  final DateTime? billedFor;
  final VoidCallback onOpenRating;
  final VoidCallback? onAddGame;
  final VoidCallback? onRenewSubscription;
  final VoidCallback? onCustomColumns;
  final VoidCallback? onHideRating;

  const ClubActionsSection({
    super.key,
    required this.isOwner,
    required this.onOpenRating,
    this.billedFor,
    this.onAddGame,
    this.onRenewSubscription,
    this.onCustomColumns,
    this.onHideRating,
  });

  @override
  Widget build(BuildContext context) {
    return context.isMobile ? _buildMobile(context) : _buildDesktop(context);
  }

  Widget _buildDesktop(BuildContext context) {
    final locale = context.locale;
    final theme = context.theme;
    final cards = <Widget>[
      ClubActionCard(
        icon: Icons.leaderboard_outlined,
        iconBackgroundColor: theme.textColor,
        title: locale.clubActionOpenRating,
        subtitle: locale.clubActionOpenRatingSubtitle,
        onTap: onOpenRating,
      ),
    ];

    if (isOwner) {
      cards.add(
        ClubActionCard(
          icon: Icons.add_circle_outline,
          iconBackgroundColor: theme.successColor,
          title: locale.clubActionAddGame,
          subtitle: locale.clubActionAddGameSubtitle,
          onTap: onAddGame!,
        ),
      );
      if (onRenewSubscription != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.star_outline,
            iconBackgroundColor: theme.positiveColor,
            title: locale.clubActionRenewSubscription,
            subtitle: billedFor != null
                ? locale.clubActionPaidUntil(
                    DateFormat('dd.MM.yyyy').format(billedFor!),
                  )
                : '',
            onTap: onRenewSubscription!,
          ),
        );
      }
      if (onCustomColumns != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.view_column_outlined,
            iconBackgroundColor: theme.darkGreyColor,
            title: locale.clubActionCustomColumns,
            subtitle: locale.clubActionCustomColumnsSubtitle,
            onTap: onCustomColumns!,
          ),
        );
      }
      if (onHideRating != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.visibility_off_outlined,
            iconBackgroundColor: theme.redColor,
            title: locale.clubActionHideRating,
            subtitle: locale.clubActionHideRatingSubtitle,
            onTap: onHideRating!,
          ),
        );
      }
    }

    if (cards.length == 1) {
      return cards.first;
    }

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: cards,
    );
  }

  Widget _buildMobile(BuildContext context) {
    final locale = context.locale;
    final theme = context.theme;
    final cards = <Widget>[
      ClubActionCard(
        icon: Icons.leaderboard_outlined,
        iconBackgroundColor: context.theme.textColor,
        title: locale.clubActionOpenRating,
        subtitle: locale.clubActionOpenRatingSubtitle,
        onTap: onOpenRating,
        showChevron: true,
      ),
    ];

    if (isOwner) {
      if (onAddGame != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.add_circle_outline,
            iconBackgroundColor: theme.successColor,
            title: locale.clubActionAddGame,
            subtitle: locale.clubActionAddGameSubtitle,
            onTap: onAddGame!,
            showChevron: true,
          ),
        );
      }
      if (onRenewSubscription != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.star_outline,
            iconBackgroundColor: theme.positiveColor,
            title: locale.clubActionRenewSubscription,
            subtitle: billedFor != null
                ? locale.clubActionPaidUntil(
                    DateFormat('dd.MM.yyyy').format(billedFor!),
                  )
                : '',
            onTap: onRenewSubscription!,
            showChevron: true,
          ),
        );
      }
      if (onCustomColumns != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.view_column_outlined,
            iconBackgroundColor: theme.darkGreyColor,
            title: locale.clubActionCustomColumns,
            subtitle: locale.clubActionCustomColumnsSubtitle,
            onTap: onCustomColumns!,
            showChevron: true,
          ),
        );
      }
      if (onHideRating != null) {
        cards.add(
          ClubActionCard(
            icon: Icons.visibility_off_outlined,
            iconBackgroundColor: theme.redColor,
            title: locale.clubActionHideRating,
            subtitle: locale.clubActionHideRatingSubtitle,
            onTap: onHideRating!,
            showChevron: true,
          ),
        );
      }
    }

    return Column(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          cards[i],
          if (i < cards.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}
