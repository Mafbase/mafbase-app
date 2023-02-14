import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
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
          body: ListView.builder(
            itemCount: state.tournaments.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      AppLocalizations.of(context)!.tournamentsListTitle,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(left: 270, right: 270, bottom: 10,),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      context.read<MainBloc>().add(
                        MainEvent.tournamentSelected(
                          tournamentId: state.tournaments[index].id,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: MaterialStatePropertyAll(
                          tapped == index
                              ? const Color(0xFFA7A7A7)
                              : (hovered == index
                              ? const Color(0xFFE3E3E3)
                              : MyTheme.of(context)
                              .greyColor
                              .withOpacity(0.16)),
                        ).value,
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .format(state.tournaments[index].dateStart),
                            style: MyTheme.of(context).defaultTextStyle,
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Text(
                            state.tournaments[index].name,
                            style: MyTheme.of(context).defaultTextStyle,
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    color: getColor(
                                      state.tournaments[index].status,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  getText(state.tournaments[index].status),
                                  style: MyTheme.of(context).defaultTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton.large(
            elevation: 10,
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
