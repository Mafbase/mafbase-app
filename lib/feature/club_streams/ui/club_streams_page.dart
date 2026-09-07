import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/club_streams/bloc/club_streams_admin_bloc.dart';
import 'package:seating_generator_web/feature/club_streams/bloc/club_streams_admin_event.dart';
import 'package:seating_generator_web/feature/club_streams/bloc/club_streams_admin_state.dart';
import 'package:seating_generator_web/feature/club_streams/ui/widgets/club_stream_expansion_tile.dart';
import 'package:seating_generator_web/feature/club_streams/ui/widgets/club_stream_settings_sheet.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/add_stream_bottom_sheet.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class ClubStreamsPage extends StatelessWidget {
  final int clubId;

  const ClubStreamsPage({super.key, @PathParam('clubId') required this.clubId});

  @override
  Widget build(BuildContext context) {
    final streamRepository = RepositoryFactory.of(context).streamRepository;
    return BlocProvider<ClubStreamsAdminBloc>(
      create: (_) => ClubStreamsAdminBloc(streamRepository)..add(ClubStreamsAdminEventPageOpened(clubId: clubId)),
      child: ClubStreamsPageContent(clubId: clubId),
    );
  }
}

class ClubStreamsPageContent extends StatelessWidget {
  final int clubId;

  const ClubStreamsPageContent({super.key, required this.clubId});

  Map<int, List<GameStreamAdmin>> _groupByTable(List<GameStreamAdmin> streams) {
    final map = <int, List<GameStreamAdmin>>{};
    for (final stream in streams) {
      map.putIfAbsent(stream.tableNumber, () => []).add(stream);
    }
    // Sort active streams first, then by startedAt descending
    for (final list in map.values) {
      list.sort((a, b) {
        final activeCompare = (b.active ? 1 : 0) - (a.active ? 1 : 0);
        if (activeCompare != 0) return activeCompare;
        return b.startedAt.compareTo(a.startedAt);
      });
    }
    return Map.fromEntries(map.entries.toList()..sort((a, b) => a.key.compareTo(b.key)));
  }

  void _openAddStream(BuildContext context) {
    AddStreamBottomSheet.show(context).then((result) {
      if (result != null && context.mounted) {
        context.read<ClubStreamsAdminBloc>().add(
              ClubStreamsAdminEventSetStream(
                tableNumber: result.tableNumber,
                viewerUrl: result.viewerUrl,
                rtmpServerUrl: result.rtmpServerUrl,
                rtmpKey: result.rtmpKey,
              ),
            );
      }
    });
  }

  void _onStop(BuildContext context, int streamId) {
    context.read<ClubStreamsAdminBloc>().add(ClubStreamsAdminEventStopStream(streamId: streamId));
  }

  void _onRotateToken(BuildContext context, int streamId, int tableNumber) {
    ConfirmDialog.open(context, context.locale.streamsRotateTokenConfirm(tableNumber)).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<ClubStreamsAdminBloc>().add(ClubStreamsAdminEventRotateToken(streamId: streamId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final theme = MyTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.backOrGoToDefault()),
        title: Text(locale.clubStreamsTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: locale.clubStreamSettingsTitle,
            onPressed: () => ClubStreamSettingsSheet.show(context, clubId: clubId),
          ),
        ],
      ),
      body: BlocBuilder<ClubStreamsAdminBloc, ClubStreamsAdminState>(
        builder: (context, state) {
          final grouped = _groupByTable(state.streams);
          final entries = grouped.entries.toList();

          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: grouped.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.videocam_off_outlined, size: 64, color: theme.greyColor),
                                const SizedBox(height: 16),
                                Text(
                                  locale.streamsEmpty,
                                  style: theme.defaultTextStyle.copyWith(color: theme.greyColor),
                                ),
                                const SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: CustomButton(
                                    text: locale.streamsAddButton,
                                    onTap: () => _openAddStream(context),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: entries.length,
                            itemBuilder: (ctx, index) {
                              final entry = entries[index];
                              return ClubStreamExpansionTile(
                                clubId: clubId,
                                tableNumber: entry.key,
                                streams: entry.value,
                                onStop: (streamId) => _onStop(context, streamId),
                                onRotateToken: (streamId) => _onRotateToken(context, streamId, entry.key),
                              );
                            },
                          ),
                  ),
                  if (grouped.isNotEmpty) _BottomBar(onAdd: () => _openAddStream(context)),
                ],
              ),
              if (state.isLoading) const Positioned.fill(child: LoadingOverlayWidget()),
            ],
          );
        },
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final VoidCallback onAdd;

  const _BottomBar({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    return Container(
      decoration: BoxDecoration(
        color: theme.background2,
        border: Border(top: BorderSide(color: theme.borderColor)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: CustomButton(text: locale.streamsAddButton, onTap: onAdd),
    );
  }
}
