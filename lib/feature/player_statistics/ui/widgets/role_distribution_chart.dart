import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/utils.dart';

class RoleDistributionChart extends StatelessWidget {
  final PlayerStatisticsModel statistics;

  const RoleDistributionChart({super.key, required this.statistics});

  @override
  Widget build(BuildContext context) {
    final segments = _buildSegments(context);
    final totalGames = statistics.overall.games;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        runSpacing: 8,
        children: [
          SizedBox(
            width: 140,
            height: 140,
            child: CustomPaint(
              painter: _DonutChartPainter(segments: segments),
              child: Center(
                child: Text(
                  totalGames.toString(),
                  style: MyTheme.of(context).headerTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: segments.map((s) => _LegendItem(segment: s, totalGames: totalGames)).toList(),
          ),
        ],
      ),
    );
  }

  List<_ChartSegment> _buildSegments(BuildContext context) {
    return [
      _ChartSegment(
        label: context.locale.playerStatsCitizen,
        games: statistics.citizen.games,
        color: const Color(0xFFE53935),
      ),
      _ChartSegment(
        label: context.locale.playerStatsMafia,
        games: statistics.mafia.games,
        color: const Color(0xFF616161),
      ),
      _ChartSegment(
        label: context.locale.playerStatsDon,
        games: statistics.don.games,
        color: const Color(0xFF000000),
      ),
      _ChartSegment(
        label: context.locale.playerStatsSheriff,
        games: statistics.sheriff.games,
        color: const Color(0xFF4CAF50),
      ),
    ];
  }
}

class _ChartSegment {
  final String label;
  final int games;
  final Color color;

  const _ChartSegment({
    required this.label,
    required this.games,
    required this.color,
  });
}

class _LegendItem extends StatelessWidget {
  final _ChartSegment segment;
  final int percentage;

  _LegendItem({required this.segment, required int totalGames})
      : percentage = totalGames > 0 ? (segment.games / totalGames * 100).round() : 0;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: segment.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${segment.label}: ${segment.games} ($percentage%)',
              style: MyTheme.of(context).defaultTextStyle,
            ),
          ],
        ),
      );
}

class _DonutChartPainter extends CustomPainter {
  final List<_ChartSegment> segments;

  _DonutChartPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final totalGames = segments.fold<int>(0, (sum, s) => sum + s.games);
    if (totalGames == 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    const strokeWidth = 20.0;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius - strokeWidth / 2,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    var startAngle = -pi / 2;
    for (final segment in segments) {
      if (segment.games == 0) continue;
      final sweepAngle = (segment.games / totalGames) * 2 * pi;
      paint.color = segment.color;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.segments != segments;
  }
}
