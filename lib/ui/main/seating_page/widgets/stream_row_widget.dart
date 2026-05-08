import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamRowWidget extends StatelessWidget {
  final int tableNumber;
  final List<GameStream> allStreams;

  const StreamRowWidget({
    super.key,
    required this.tableNumber,
    required this.allStreams,
  });

  List<GameStream> get _tableStreams => allStreams.where((s) => s.tableNumber == tableNumber).toList();

  GameStream? get _activeStream => _tableStreams.where((s) => s.active).firstOrNull;

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

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }

  void _showAllStreams(BuildContext context) {
    final streams = _tableStreams;
    if (streams.isEmpty) return;
    final locale = context.locale;
    final theme = MyTheme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (ctx, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(child: Text(locale.streamsTableTitle(tableNumber), style: theme.headerTextStyle)),
                  const CloseButton(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(8),
                itemCount: streams.length,
                itemBuilder: (_, index) {
                  final stream = streams[index];
                  final isActive = stream.active;
                  return ListTile(
                    leading: _StreamStatusChip(active: isActive),
                    title: Text(
                      stream.hasViewerUrl() ? stream.viewerUrl : '',
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      _formatTime(stream.startedAt),
                      style: TextStyle(fontSize: 11, color: theme.greyColor),
                    ),
                    onTap: stream.hasViewerUrl() ? () => _openUrl(stream.viewerUrl) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final active = _activeStream;
    if (active == null) return const SizedBox.shrink();

    final theme = MyTheme.of(context);
    final locale = context.locale;
    final time = _formatTime(active.startedAt);
    final tableStreams = _tableStreams;

    return InkWell(
      onTap: active.hasViewerUrl() ? () => _openUrl(active.viewerUrl) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            const _StreamStatusChip(active: true),
            const SizedBox(width: 6),
            Text(time, style: TextStyle(fontSize: 11, color: theme.greyColor)),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                active.hasViewerUrl() ? active.viewerUrl : locale.streamsNoUrl,
                style: TextStyle(
                  fontSize: 12,
                  color: active.hasViewerUrl() ? theme.darkBlueColor : theme.greyColor,
                  decoration: active.hasViewerUrl() ? TextDecoration.underline : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (tableStreams.length > 1)
              IconButton(
                onPressed: () => _showAllStreams(context),
                icon: const Icon(Icons.expand_more, size: 18),
                tooltip: locale.streamsShowAll,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }
}

class _StreamStatusChip extends StatelessWidget {
  final bool active;
  const _StreamStatusChip({required this.active});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: active ? Colors.red : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        active ? '● ${locale.streamsLive}' : locale.streamsEnded,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
      ),
    );
  }
}
