import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/confirm_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/common/widgets/loading_overlay.dart';
import 'package:seating_generator_web/feature/fantasy/domain/models/fantasy_prediction_item_model.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_bloc.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_state.dart';
import 'package:seating_generator_web/data/notifiers/auth_notifier.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/ui/main/tournament_page/tournament_page_bloc.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class FantasyPage extends StatefulWidget {
  final int tournamentId;
  final bool isOwner;

  const FantasyPage({
    super.key,
    required this.tournamentId,
    required this.isOwner,
  });

  @override
  State<FantasyPage> createState() => _FantasyPageState();

  static String createTournamentLocation({
    required int tournamentId,
    required BuildContext context,
  }) {
    return context.namedLocation(
      _tournamentName,
      pathParameters: {
        "id": tournamentId.toString(),
      },
    );
  }

  static const _tournamentName = 'tournament_fantasy';

  static final GoRoute tournamentRoute = GoRoute(
    path: 'fantasy',
    name: _tournamentName,
    builder: (context, state) {
      final tournamentId = int.parse(state.pathParameters["id"]!);
      final isOwner = context.watch<TournamentPageBloc>().state.isMyTournament;
      final userId = context.read<AuthNotifier>().value.mapOrNull(
            authorized: (model) => model.userId,
          );

      return BlocProvider<FantasyBloc>(
        key: ValueKey("$tournamentId$isOwner"),
        create: (context) => getIt<FantasyBloc>(param1: context)
          ..add(
            FantasyEventInit(
              tournamentId: tournamentId,
              isOwner: isOwner,
              userId: userId,
            ),
          ),
        child: FantasyPage(
          tournamentId: tournamentId,
          isOwner: isOwner,
        ),
      );
    },
  );
}

class _FantasyPageState extends CustomState<FantasyPage> {
  @override
  Widget? buildMobile(BuildContext context) => BlocBuilder<FantasyBloc, FantasyState>(
        builder: (context, state) {
          if (state.isLoading && state.rating == null) {
            return const LoadingOverlayWidget();
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      context.locale.fantasy,
                      style: MyTheme.of(context).headerTextStyle,
                    ),
                    if (state.isOwner)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () => _showParticipantsBottomSheet(context, state),
                            icon: const Icon(Icons.people),
                            tooltip: context.locale.fantasyParticipants,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildPredictionSection(context, state, isMobile: true),
                      const SizedBox(height: 16),
                      _buildRatingSection(context, state, isMobile: true),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );

  @override
  Widget buildDesktop(BuildContext context) => BlocBuilder<FantasyBloc, FantasyState>(
        builder: (context, state) {
          if (state.isLoading && state.rating == null) {
            return const LoadingOverlayWidget();
          }
          return Column(
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    context.locale.fantasy,
                    style: MyTheme.of(context).headerTextStyle,
                  ),
                  if (state.isOwner)
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => _showParticipantsBottomSheet(context, state),
                          icon: const Icon(Icons.people),
                          tooltip: context.locale.fantasyParticipants,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _buildRatingSection(context, state),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildPredictionSection(context, state),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ],
          );
        },
      );

  Widget _buildRatingSection(BuildContext context, FantasyState state, {bool isMobile = false}) {
    if (state.rating == null || state.rating!.rows.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.fantasyRatingEmpty,
            textAlign: TextAlign.center,
            style: MyTheme.of(context).defaultTextStyle,
          ),
        ),
      );
    }

    final ratingContent = ListView.builder(
      shrinkWrap: isMobile,
      physics: isMobile ? const NeverScrollableScrollPhysics() : null,
      itemCount: state.rating!.rows.length,
      itemBuilder: (context, index) {
        final row = state.rating!.rows[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${index + 1}. ${row.nickname}',
                      style: MyTheme.of(context).defaultTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Text(
                    context.locale.fantasyPoints(row.totalPoints),
                    style: MyTheme.of(context).defaultTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: row.predictions.map((prediction) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getPredictionColor(context, prediction),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${context.locale.fantasyGame(prediction.gameNumber)}: ${_getPredictionText(context, prediction)}',
                      style: MyTheme.of(context).defaultTextStyle.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.locale.fantasyRating,
          style: MyTheme.of(context).headerTextStyle,
        ),
        const SizedBox(height: 8),
        if (isMobile) ratingContent else Expanded(child: ratingContent),
      ],
    );
  }

  Widget _buildPredictionSection(BuildContext context, FantasyState state, {bool isMobile = false}) {
    final currentGameInfo = state.currentGameInfo;
    if (currentGameInfo == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            context.locale.fantasyCurrentGameInfoUnavailable,
            textAlign: TextAlign.center,
            style: MyTheme.of(context).defaultTextStyle,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          context.locale.fantasyCurrentGame,
          style: MyTheme.of(context).headerTextStyle,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  context.locale.fantasyGame(currentGameInfo.gameNumber),
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              if (!currentGameInfo.canParticipate) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.locale.fantasyNotParticipating,
                          style: MyTheme.of(context).defaultTextStyle.copyWith(
                                color: Colors.orange.shade700,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (currentGameInfo.canPredict) ...[
                Text(
                  context.locale.fantasyYourPrediction,
                  style: MyTheme.of(context).defaultTextStyle,
                ),
                const SizedBox(height: 8),
                CustomDropdown<GameWin>(
                  initValue: state.selectedPrediction,
                  mapToString: (win) => _getGameWinText(context, win) ?? '',
                  items: GameWin.values,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<FantasyBloc>().add(
                            FantasyEventSetPrediction(
                              tournamentId: widget.tournamentId,
                              prediction: value,
                            ),
                          );
                    }
                  },
                ),
              ] else ...[
                Text(
                  context.locale.fantasyPredictionTimeExpired,
                  style: MyTheme.of(context).defaultTextStyle.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  void _showParticipantsBottomSheet(BuildContext context, FantasyState state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) => BlocProvider.value(
          value: context.read<FantasyBloc>(),
          child: BlocBuilder<FantasyBloc, FantasyState>(
            builder: (context, blocState) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        context.locale.fantasyParticipants,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await _showAddParticipantDialog(context);
                          // Обновляем список участников после добавления
                          if (context.mounted) {
                            context.read<FantasyBloc>().add(
                                  FantasyEventLoadParticipants(tournamentId: widget.tournamentId),
                                );
                          }
                        },
                        icon: const Icon(Icons.add),
                        tooltip: context.locale.fantasyAddParticipant,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: blocState.participants.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              context.locale.fantasyNoParticipants,
                              textAlign: TextAlign.center,
                              style: MyTheme.of(context).defaultTextStyle,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: blocState.participants.length,
                          itemBuilder: (context, index) {
                            final participant = blocState.participants[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      participant.email,
                                      style: MyTheme.of(context).defaultTextStyle,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final shouldRemove = await ConfirmDialog.open(
                                        context,
                                        context.locale.fantasyRemoveParticipant(participant.email),
                                      );
                                      if (shouldRemove == true && context.mounted) {
                                        context.read<FantasyBloc>().add(
                                              FantasyEventRemoveParticipant(
                                                tournamentId: widget.tournamentId,
                                                userId: participant.id,
                                              ),
                                            );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: MyTheme.of(context).redColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddParticipantDialog(BuildContext context) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (dialogContext) => CustomDialog(
        child: Container(
          width: 580,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.locale.fantasyAddParticipant,
                  style: MyTheme.of(context).headerTextStyle,
                ),
                const SizedBox(height: 24),
                Form(
                  key: formKey,
                  child: CustomTextField(
                    readOnly: false,
                    controller: controller,
                    label: context.locale.fantasyEmail,
                    validate: (value) {
                      if (value != null) {
                        if (EmailValidator.validate(value)) {
                          return null;
                        }
                      }
                      return context.locale.fantasyEmailInvalid;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: context.locale.add,
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      Navigator.pop(dialogContext);
                      context.read<FantasyBloc>().add(
                            FantasyEventAddParticipant(
                              tournamentId: widget.tournamentId,
                              email: controller.text,
                            ),
                          );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Future.delayed(Duration(seconds: 1), controller.dispose);
  }

  Color _getPredictionColor(
    BuildContext context,
    FantasyPredictionItemModel prediction,
  ) {
    if (prediction.actualResult == null) {
      return Colors.grey;
    }
    if (prediction.prediction == prediction.actualResult) {
      return Colors.green;
    }
    return Colors.red;
  }

  String _getPredictionText(
    BuildContext context,
    FantasyPredictionItemModel prediction,
  ) {
    final predictionText = prediction.prediction != null
        ? _getGameWinText(context, prediction.prediction!)
        : context.locale.fantasyNoPrediction;
    final resultText = prediction.actualResult != null ? _getGameWinText(context, prediction.actualResult!) : '?';
    return '$predictionText${context.locale.fantasyPredictionSeparator}$resultText (${prediction.points}${context.locale.fantasyPointsShort})';
  }

  String? _getGameWinText(BuildContext context, GameWin? win) {
    switch (win) {
      case GameWin.city:
        return context.locale.cityWon;
      case GameWin.mafia:
        return context.locale.mafiaWon;
      case GameWin.draw:
        return context.locale.draw;
      default:
        return null;
    }
  }
}
