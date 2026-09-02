import 'package:flutter/material.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// Публичный список активных трансляций клуба — виден всем пользователям.
class ClubActiveStreamsCard extends StatelessWidget {
  final List<GameStream> streams;

  const ClubActiveStreamsCard({super.key, required this.streams});

  List<GameStream> get _activeStreams => streams.where((s) => s.active).toList();

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final active = _activeStreams;
    if (active.isEmpty) return const SizedBox.shrink();

    final theme = context.theme;
    final locale = context.locale;

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
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              children: [
                Icon(Icons.fiber_manual_record, size: 12, color: theme.redColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    locale.clubStreamsPublicTitle,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < active.length; i++) ...[
                  _StreamRow(stream: active[i], onOpen: _openUrl),
                  if (i < active.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StreamRow extends StatelessWidget {
  final GameStream stream;
  final ValueChanged<String> onOpen;

  const _StreamRow({required this.stream, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;
    final hasUrl = stream.hasViewerUrl();

    return Material(
      color: theme.btnColor2,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: hasUrl ? () => onOpen(stream.viewerUrl) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  locale.streamsTableTitle(stream.tableNumber),
                  style: TextStyle(color: theme.btnTextColor, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                hasUrl ? locale.streamsWatch : locale.streamsNoUrl,
                style: TextStyle(color: theme.btnTextColor.withValues(alpha: 0.8), fontSize: 12),
              ),
              if (hasUrl) ...[
                const SizedBox(width: 6),
                Icon(Icons.open_in_new, size: 14, color: theme.btnTextColor.withValues(alpha: 0.8)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
