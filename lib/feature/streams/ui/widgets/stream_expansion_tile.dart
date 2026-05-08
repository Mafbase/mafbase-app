import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/domain/models/game_stream_admin_model.dart';
import 'package:seating_generator_web/utils.dart';

class StreamExpansionTile extends StatelessWidget {
  final int tableNumber;
  final List<GameStreamAdminModel> streams;
  final void Function(int streamId) onStop;

  const StreamExpansionTile({
    super.key,
    required this.tableNumber,
    required this.streams,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final activeStream = streams.where((s) => s.active).firstOrNull ?? streams.firstOrNull;
    final inactiveStreams = streams.where((s) => !s.active).toList();

    if (activeStream == null) return const SizedBox.shrink();

    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      title: Text(
        locale.streamsTableTitle(tableNumber),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: _StreamItem(stream: activeStream, onStop: onStop),
      children: [
        if (inactiveStreams.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                locale.streamsPrevious,
                style: TextStyle(fontSize: 12, color: MyTheme.of(context).greyColor),
              ),
            ),
          ),
          for (final stream in inactiveStreams)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _StreamItem(stream: stream, onStop: onStop),
            ),
        ],
      ],
    );
  }
}

class _StreamItem extends StatelessWidget {
  final GameStreamAdminModel stream;
  final void Function(int streamId) onStop;

  const _StreamItem({required this.stream, required this.onStop});

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
                if (isActive)
                  IconButton(
                    onPressed: () => onStop(stream.id),
                    icon: const Icon(Icons.stop_circle_outlined),
                    tooltip: locale.streamsStop,
                    color: theme.redColor,
                    iconSize: 20,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            if (stream.viewerUrl != null) ...[
              const SizedBox(height: 4),
              _CopyRow(label: locale.streamsViewerUrl, value: stream.viewerUrl!),
            ],
            if (stream.rtmpServerUrl != null) ...[
              const SizedBox(height: 4),
              _CopyRow(label: locale.streamsRtmpServer, value: stream.rtmpServerUrl!),
            ],
            if (stream.rtmpKey != null) ...[
              const SizedBox(height: 4),
              _CopyRow(label: locale.streamsRtmpKey, value: stream.rtmpKey!),
            ],
          ],
        ),
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
      child: Text(
        active ? '● ${locale.streamsLive}' : locale.streamsEnded,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.locale.streamsCopied)),
              );
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
