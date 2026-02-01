import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_rating_row.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyRatingSection extends StatelessWidget {
  final FantasyState state;
  final bool isMobile;

  const FantasyRatingSection({
    super.key,
    required this.state,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    if (state.rating == null || state.rating!.rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.fantasyRatingEmpty,
            textAlign: TextAlign.center,
            style: MyTheme.of(context).defaultTextStyle,
          ),
        ),
      );
    }

    final ratingContent = ListView.builder(
      shrinkWrap: isMobile,
      physics: isMobile ? const NeverScrollableScrollPhysics() : null,
      itemCount: state.rating!.rows.length,
      itemBuilder: (context, index) {
        final row = state.rating!.rows[index];
        return FantasyRatingRow(
          row: row,
          index: index,
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.locale.fantasyRating,
          style: MyTheme.of(context).headerTextStyle,
        ),
        const SizedBox(height: 8),
        if (isMobile) ratingContent else Expanded(child: ratingContent),
      ],
    );
  }
}
