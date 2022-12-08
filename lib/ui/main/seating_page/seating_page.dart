import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_event.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class SeatingPage extends StatefulWidget {
  final int tournamentId;

  const SeatingPage({Key? key, required this.tournamentId}) : super(key: key);

  @override
  State<SeatingPage> createState() => _SeatingPageState();

  static const name = 'tournament_seating';
  static final RouteBase route = GoRoute(
    path: 'editSeating',
    name: name,
    builder: (context, state) => SeatingPage(
      tournamentId: int.parse(state.params["id"] ?? ""),
    ),
  );

  static String createLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(name, params: {"id": tournamentId.toString()});
  }
}

class _SeatingPageState extends State<SeatingPage> {
  @override
  void initState() {
    context.read<SeatingPageBloc>().add(
          SeatingPageEvent.pageOpened(
            tournamentId: widget.tournamentId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatingPageBloc, SeatingPageState>(
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    context.locale.separateTitle,
                    style: MyTheme.of(context).headerTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.cannotMeet.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                                state.cannotMeet[index].first,
                                state.cannotMeet[index].second
                              ]
                                  .map<Widget>(
                                    (playerModel) => Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                MyTheme.of(context).borderColor,
                                          ),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              playerModel.nickname,
                                              style: MyTheme.of(context)
                                                  .defaultTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList() +
                              <Widget>[
                                IconButton(
                                  onPressed: () {
                                    final bloc =
                                        context.read<SeatingPageBloc>();
                                    showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          const ConfirmDialog(),
                                    ).then(
                                      (value) {
                                        if (value == true) {
                                          bloc.add(
                                            SeatingPageEvent.deletePair(
                                              first:
                                                  state.cannotMeet[index].first,
                                              second: state
                                                  .cannotMeet[index].second,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: MyTheme.of(context).redColor,
                                  ),
                                )
                              ],
                        );
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<SeatingPageBloc>().add(
                            const SeatingPageEvent.addPair(),
                          );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        context.locale.addSeparationBtnText,
                        style: MyTheme.of(context).textBtnTextStyle,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      context.read<SeatingPageBloc>().add(
                            const SeatingPageEvent.fsmSeatingTapped(),
                          );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Загрузить готовую рассадку",
                        style: MyTheme.of(context).textBtnTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.isLoading)
              const Positioned.fill(child: LoadingOverlayWidget()),
          ],
        );
      },
    );
  }
}
