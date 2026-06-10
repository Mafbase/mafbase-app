import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/bloc_extension.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_bloc.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_event.dart';
import 'package:seating_generator_web/feature/streams/bloc/streams_admin_state.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/add_stream_bottom_sheet.dart';
import 'package:seating_generator_web/feature/streams/ui/widgets/stream_expansion_tile.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class StreamsPage extends StatelessWidget {
  final int tournamentId;

  const StreamsPage({super.key, @PathParam('id') required this.tournamentId});

  @override
  Widget build(BuildContext context) {
    final streamRepository = RepositoryFactory.of(context).streamRepository;
    return BlocProvider<StreamsAdminBloc>(
      create: (_) => StreamsAdminBloc(streamRepository)..add(StreamsAdminEventPageOpened(tournamentId: tournamentId)),
      child: StreamsPageContent(tournamentId: tournamentId),
    );
  }
}

class StreamsPageContent extends StatelessWidget {
  final int tournamentId;

  const StreamsPageContent({super.key, required this.tournamentId});

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
        context.read<StreamsAdminBloc>().add(
          StreamsAdminEventSetStream(
            tableNumber: result.tableNumber,
            viewerUrl: result.viewerUrl,
            rtmpServerUrl: result.rtmpServerUrl,
            rtmpKey: result.rtmpKey,
          ),
        );
      }
    });
  }

  // ignore: unused_element
  void _openGenerateStream(BuildContext context) {
    GenerateStreamBottomSheet.show(context).then((tableNumber) {
      if (tableNumber != null && context.mounted) {
        context.read<StreamsAdminBloc>().add(StreamsAdminEventGenerateStream(tableNumber: tableNumber));
      }
    });
  }

  void _onStop(BuildContext context, int streamId) {
    context.read<StreamsAdminBloc>().add(StreamsAdminEventStopStream(streamId: streamId));
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final theme = MyTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: context.backOrGoToDefault()),
        title: Text(locale.streamsTitle),
        actions: [TournamentMenuAction(openDrawer: () => Scaffold.of(context).openEndDrawer())],
      ),
      body: BlocBuilder<StreamsAdminBloc, StreamsAdminState>(
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
                              return StreamExpansionTile(
                                tableNumber: entry.key,
                                streams: entry.value,
                                onStop: (streamId) => _onStop(context, streamId),
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
