import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/domain/models/tournament_model.dart';
import 'package:seating_generator_web/ui/main/main_bloc.dart';
import 'package:seating_generator_web/ui/main/main_event.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_bloc.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_events.dart';
import 'package:seating_generator_web/ui/main/tournaments_list/tournaments_state.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  int tapped = -1;
  int hovered = -1;

  @override
  void initState() {
    super.initState();
    context.read<TournamentsBloc>().add(const TournamentsEvent.opened());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentsBloc, TournamentsState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.tournamentsListTitle,
                          style: MyTheme.of(context).headerTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(
                          border: TableBorder.all(
                            color:
                                MyTheme.of(context).textColor.withOpacity(0.2),
                          ),
                          columns: [
                            AppLocalizations.of(context)!
                                .tournamentsListNameHeader,
                            AppLocalizations.of(context)!
                                .tournamentsListStatusHeader,
                            AppLocalizations.of(context)!
                                .tournamentsListDateHeader,
                            AppLocalizations.of(context)!
                                .tournamentsListGamesCountHeader
                          ]
                              .map(
                                (e) => DataColumn(
                                  label: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e,
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          rows: [
                            ...state.tournaments.mapIndexed(
                              (index, e) => DataRow(
                                color: MaterialStatePropertyAll(
                                  tapped == index
                                      ? const Color(0xFFA7A7A7)
                                      : (hovered == index
                                          ? const Color(0xFFE3E3E3)
                                          : null),
                                ),
                                cells: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.name,
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          decoration: BoxDecoration(
                                            color: getColor(e.status),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          getText(e.status),
                                          style: MyTheme.of(context)
                                              .defaultTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(e.dateStart),
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.gamesCount.toString(),
                                      style:
                                          MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                ]
                                    .map(
                                      (e) => DataCell(
                                        MouseRegion(
                                          onEnter: (_) => setState(() {
                                            hovered = index;
                                          }),
                                          onExit: (_) => setState(() {
                                            hovered = -1;
                                          }),
                                          child: GestureDetector(
                                            onTapDown: (_) => setState(() {
                                              tapped = index;
                                            }),
                                            onTapUp: (_) => setState(
                                              () {
                                                tapped = -1;
                                                context.read<MainBloc>().add(
                                                      MainEvent
                                                          .tournamentSelected(
                                                        tournamentId: state
                                                            .tournaments[index]
                                                            .id,
                                                      ),
                                                    );
                                              },
                                            ),
                                            onTapCancel: () => setState(() {
                                              tapped = -1;
                                            }),
                                            child: Container(
                                              color: const Color(0x00000000),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    e.child ?? Container(),
                                                    const Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.isLoading) const LoadingOverlayWidget(),
            ],
          ),
          floatingActionButton: FloatingActionButton.large(
            onPressed: () {
              context
                  .read<TournamentsBloc>()
                  .add(const TournamentsEvent.create());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  String getText(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.active:
        return AppLocalizations.of(context)!.tournamentStatusActive;
      case TournamentStatus.waitForBilling:
        return AppLocalizations.of(context)!.tournamentStatusWaitForBilling;
      case TournamentStatus.ended:
        return AppLocalizations.of(context)!.tournamentStatusEnded;
    }
  }

  Color getColor(TournamentStatus status) {
    switch (status) {
      case TournamentStatus.active:
        return const Color(0xFF66CCA7);
      case TournamentStatus.waitForBilling:
        return const Color(0xFFFFE600);
      case TournamentStatus.ended:
        return const Color(0xFFDE5462);
    }
  }
}
