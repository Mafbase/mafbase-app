import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/feature/streams/domain/broadcast_link.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';
import 'package:seating_generator_web/utils/platform.dart';

/// Ссылка оператора стола турнира или клуба; без RTMP-сервера и ключа вместо неё подсказка.
class StreamOperatorLinkSection extends StatelessWidget {
  final int? tournamentId;
  final int? clubId;
  final int table;
  final GameStreamAdmin stream;

  const StreamOperatorLinkSection({
    super.key,
    this.tournamentId,
    this.clubId,
    required this.table,
    required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    if (stream.rtmpServerUrl.isEmpty || stream.rtmpKey.isEmpty) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: theme.darkGreyColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              locale.streamsOperatorNoRtmpHint,
              style: TextStyle(fontSize: 12, color: theme.darkGreyColor),
            ),
          ),
        ],
      );
    }

    final link = buildBroadcastDeeplink(
      tournamentId: tournamentId,
      clubId: clubId,
      table: table,
      token: stream.broadcastToken,
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        TextButton.icon(
          onPressed: () => copyLink(context, link, message: locale.broadcastOperatorLinkCopied),
          icon: const Icon(Icons.link, size: 18),
          label: Text(locale.streamsOperatorLink),
          style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
        ),
        if (!isWebPlatform) ...[
          Builder(
            builder: (buttonContext) => IconButton(
              onPressed: () => shareLink(buttonContext, link),
              icon: const Icon(Icons.share_outlined),
              tooltip: locale.streamsShareOperatorLink,
              color: theme.darkGreyColor,
              iconSize: 18,
              visualDensity: VisualDensity.compact,
            ),
          ),
          TextButton.icon(
            onPressed: () => context.router.push(
              BroadcastRoute(
                tournamentId: tournamentId ?? 0,
                clubId: clubId ?? 0,
                table: table,
                broadcastKey: stream.broadcastToken,
              ),
            ),
            icon: const Icon(Icons.videocam_outlined, size: 18),
            label: Text(locale.streamsStartOnThisPhone),
            style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
          ),
        ],
      ],
    );
  }
}
