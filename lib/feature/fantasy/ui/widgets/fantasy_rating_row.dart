import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_rating_row_model.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_prediction_chip.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyRatingRow extends StatelessWidget {
  final FantasyRatingRowModel row;
  final int index;

  const FantasyRatingRow({
    super.key,
    required this.row,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${index + 1}. ${row.nickname}',
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Text(
                context.locale.fantasyPoints(row.totalPoints),
                style: MyTheme.of(context).defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: row.predictions.map((prediction) => FantasyPredictionChip(prediction: prediction)).toList(),
          ),
        ],
      ),
    );
  }
}
