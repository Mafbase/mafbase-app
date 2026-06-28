import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/streams/domain/broadcast_link.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

class StreamExpansionTile extends StatelessWidget {
  final int tournamentId;
  final int tableNumber;
  final List<GameStreamAdmin> streams;
  final void Function(int streamId) onStop;

  const StreamExpansionTile({
    super.key,
    required this.tournamentId,
    required this.tableNumber,
    required this.streams,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final activeStream = streams.where((s) => s.active).firstOrNull ?? streams.firstOrNull;
    final inactiveStreams = streams.where((s) => !s.active && s.id != activeStream?.id).toList();

    if (activeStream == null) return const SizedBox.shrink();

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      title: Text(locale.streamsTableTitle(tableNumber), style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: _StreamItem(
        tournamentId: tournamentId,
        tableNumber: tableNumber,
        stream: activeStream,
        onStop: activeStream.active ? onStop : null,
      ),
      children: [
        if (inactiveStreams.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(locale.streamsPrevious, style: TextStyle(fontSize: 12, color: MyTheme.of(context).greyColor)),
            ),
          ),
          for (final stream in inactiveStreams)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _StreamItem(
                tournamentId: tournamentId,
                tableNumber: tableNumber,
                stream: stream,
                onStop: null,
              ),
            ),
        ],
      ],
    );
  }
}

class _StreamItem extends StatelessWidget {
  final int tournamentId;
  final int tableNumber;
  final GameStreamAdmin stream;
  final void Function(int streamId)? onStop;

  const _StreamItem({
    required this.tournamentId,
    required this.tableNumber,
    required this.stream,
    this.onStop,
  });

  String _formatTime(String startedAt) {
    try {
      final dt = DateTime.parse(startedAt);
      final local = dt.toLocal();
      final h = local.hour.toString().padLeft(2, '0');
      final m = local.minute.toString().padLeft(2, '0');
      return '$h:$m';
    } catch (_) {
      return startedAt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final isActive = stream.active;
    final time = _formatTime(stream.startedAt);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusChip(active: isActive),
                const SizedBox(width: 8),
                Text(time, style: TextStyle(fontSize: 12, color: theme.greyColor)),
                const Spacer(),
                if (isActive && onStop != null)
                  IconButton(
                    onPressed: () => onStop!(stream.id),
                    icon: const Icon(Icons.stop_circle_outlined),
                    tooltip: locale.streamsStop,
                    color: theme.redColor,
                    iconSize: 20,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            if (stream.hasViewerUrl()) ...[
              const SizedBox(height: 4),
              _CopyRow(label: locale.streamsViewerUrl, value: stream.viewerUrl),
            ],
            if (stream.hasRtmpServerUrl()) ...[
              const SizedBox(height: 4),
              _CopyRow(label: locale.streamsRtmpServer, value: stream.rtmpServerUrl),
            ],
            if (stream.hasRtmpKey()) ...[
              const SizedBox(height: 4),
              _CopyRow(label: locale.streamsRtmpKey, value: stream.rtmpKey),
            ],
            if (stream.broadcastToken.isNotEmpty) ...[
              const SizedBox(height: 8),
              _OperatorLinkButton(
                tournamentId: tournamentId,
                tableNumber: tableNumber,
                token: stream.broadcastToken,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OperatorLinkButton extends StatelessWidget {
  final int tournamentId;
  final int tableNumber;
  final String token;

  const _OperatorLinkButton({required this.tournamentId, required this.tableNumber, required this.token});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: () async {
          final link = buildBroadcastDeeplink(tournamentId: tournamentId, table: tableNumber, token: token);
          await Clipboard.setData(ClipboardData(text: link));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(locale.broadcastOperatorLinkCopied)),
            );
          }
        },
        icon: const Icon(Icons.link, size: 18),
        label: Text(locale.streamsOperatorLink),
        style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool active;
  const _StatusChip({required this.active});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: active ? Colors.red : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (active) ...[
            const Icon(Icons.fiber_manual_record, size: 8, color: Colors.white),
            const SizedBox(width: 3),
          ],
          Text(
            active ? locale.streamsLive : locale.streamsEnded,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _CopyRow extends StatelessWidget {
  final String label;
  final String value;

  const _CopyRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: theme.greyColor)),
              Text(value, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: value));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.locale.streamsCopied)));
            }
          },
          icon: const Icon(Icons.copy, size: 16),
          visualDensity: VisualDensity.compact,
          tooltip: context.locale.streamsCopy,
        ),
      ],
    );
  }
}
