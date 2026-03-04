import 'package:flutter/material.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/utils.dart';

class PlayerPairStatsSection extends StatelessWidget {
  final String title;
  final List<PlayerPairStatModel> pairs;
  final void Function(int playerId) onPlayerTap;

  const PlayerPairStatsSection({
    super.key,
    required this.title,
    required this.pairs,
    required this.onPlayerTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            if (pairs.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    context.locale.playerStatsNoData,
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              )
            else
              ...pairs.map(
                (pair) => _PairRow(pair: pair, onTap: onPlayerTap),
              ),
          ],
        ),
      ),
    );
  }
}

class _PairRow extends StatelessWidget {
  final PlayerPairStatModel pair;
  final void Function(int playerId) onTap;

  const _PairRow({required this.pair, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(pair.playerId),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                pair.nickname,
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${pair.wins}/${pair.games}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${pair.winRate.toStringAsFixed(1)}%',
                textAlign: TextAlign.end,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
