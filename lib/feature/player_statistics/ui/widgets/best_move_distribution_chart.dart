import 'dart:math';

import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/player_statistics/domain/model/player_statistics_model.dart';
import 'package:seating_generator_web/utils.dart';

class BestMoveDistributionChart extends StatelessWidget {
  final BestMoveDistributionModel distribution;

  const BestMoveDistributionChart({super.key, required this.distribution});

  @override
  Widget build(BuildContext context) {
    final segments = _buildSegments(context);
    final total = distribution.miss + distribution.one + distribution.half + distribution.full;

    if (total == 0) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.locale.playerStatsBestMoveDistribution,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
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
                      total.toString(),
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: segments.map((s) => _LegendItem(segment: s, total: total)).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<_ChartSegment> _buildSegments(BuildContext context) {
    return [
      _ChartSegment(
        label: context.locale.playerStatsBestMoveMiss,
        value: distribution.miss,
        color: const Color(0xFF9E9E9E),
      ),
      _ChartSegment(
        label: context.locale.playerStatsBestMoveOne,
        value: distribution.one,
        color: const Color(0xFFA5D6A7),
      ),
      _ChartSegment(
        label: context.locale.playerStatsBestMoveHalf,
        value: distribution.half,
        color: const Color(0xFF66BB6A),
      ),
      _ChartSegment(
        label: context.locale.playerStatsBestMoveFull,
        value: distribution.full,
        color: const Color(0xFF2E7D32),
      ),
    ];
  }
}

class _ChartSegment {
  final String label;
  final int value;
  final Color color;

  const _ChartSegment({
    required this.label,
    required this.value,
    required this.color,
  });
}

class _LegendItem extends StatelessWidget {
  final _ChartSegment segment;
  final double percentage;

  _LegendItem({required this.segment, required int total}) : percentage = total > 0 ? segment.value / total * 100 : 0;

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
              '${segment.label}: ${segment.value} (${percentage.toStringAsFixed(1)}%)',
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
    final total = segments.fold<int>(0, (sum, s) => sum + s.value);
    if (total == 0) return;

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
      if (segment.value == 0) continue;
      final sweepAngle = (segment.value / total) * 2 * pi;
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
