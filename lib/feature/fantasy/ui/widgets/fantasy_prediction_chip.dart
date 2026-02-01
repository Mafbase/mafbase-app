import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_prediction_item_model.dart';
import 'package:seating_generator_web/feature/fantasy/ui/widgets/fantasy_game_win_utils.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyPredictionChip extends StatelessWidget {
  final FantasyPredictionItemModel prediction;

  const FantasyPredictionChip({
    super.key,
    required this.prediction,
  });

  Color _getPredictionColor(BuildContext context) {
    if (prediction.actualResult == null) {
      return Colors.grey;
    }
    if (prediction.prediction == prediction.actualResult) {
      return Colors.green;
    }
    return Colors.red;
  }

  String _getPredictionText(BuildContext context) {
    final predictionText = prediction.prediction != null
        ? context.getGameWinText(prediction.prediction!)
        : context.locale.fantasyNoPrediction;
    final resultText = prediction.actualResult != null
        ? context.getGameWinText(prediction.actualResult!)
        : '?';
    return '$predictionText${context.locale.fantasyPredictionSeparator}$resultText (${prediction.points}${context.locale.fantasyPointsShort})';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: _getPredictionColor(context),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '${context.locale.fantasyGame(prediction.gameNumber)}: ${_getPredictionText(context)}',
        style: MyTheme.of(context).defaultTextStyle.copyWith(
              fontSize: 12,
              color: Colors.white,
            ),
      ),
    );
  }
}
