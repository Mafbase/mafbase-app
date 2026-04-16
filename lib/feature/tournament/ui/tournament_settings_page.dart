import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_state.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/final_players_dialog.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/tournament_menu_action.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';
import 'package:seating_generator_web/utils.dart';

@RoutePage()
class TournamentSettingsPage extends StatefulWidget {
  final int tournamentId;

  const TournamentSettingsPage({
    super.key,
    @PathParam('id') required this.tournamentId,
  });

  @override
  State<TournamentSettingsPage> createState() => _TournamentSettingsPageState();
}

class _TournamentSettingsPageState extends State<TournamentSettingsPage> {
  final defaultGamesController = TextEditingController();
  final finalGamesController = TextEditingController();
  final swissGamesController = TextEditingController();
  final bucketsController = TextEditingController();
  bool hideResult = false;
  RatingScheme? ratingScheme;
  FantasyStatus? fantasyStatus;

  final formState = GlobalKey<FormState>();
  late final VoidCallback _controllersListener;

  @override
  void initState() {
    super.initState();
    _controllersListener = () => setState(() {});
    Listenable.merge([
      defaultGamesController,
      finalGamesController,
      swissGamesController,
      bucketsController,
    ]).addListener(_controllersListener);

    final settings = context.read<TournamentPageBloc>().state.settings;
    _updateFromSettings(settings);
  }

  void _updateFromSettings(TournamentSettingsModel settings) {
    defaultGamesController.text = settings.defaultGames.toString();
    finalGamesController.text = settings.finalGames.toString();
    swissGamesController.text = settings.swissGames.toString();
    bucketsController.text = settings.buckets?.join(';') ?? '';
    hideResult = settings.hideResult;
    ratingScheme = settings.ratingScheme;
    fantasyStatus = settings.fantasyStatus;
  }

  @override
  void dispose() {
    defaultGamesController.dispose();
    swissGamesController.dispose();
    finalGamesController.dispose();
    bucketsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentPageBloc, TournamentPageState>(
      listenWhen: (prev, curr) => prev.settings != curr.settings,
      listener: (context, state) {
        _updateFromSettings(state.settings);
        setState(() {});
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: context.backOrGoToDefault(),
            ),
            title: Text(context.locale.tournamentSettingsTitle),
            actions: [
              TournamentMenuAction(
                openDrawer: () => Scaffold.of(context).openEndDrawer(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formState,
                  onChanged: () => setState(() {}),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          hint: '6',
                          validate: (value) =>
                              int.tryParse(value ?? '') == null ? context.locale.invalidNumberFormat : null,
                          label: context.locale.defaultGamesLabel,
                          controller: defaultGamesController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          validate: (value) =>
                              int.tryParse(value ?? '') == null ? context.locale.invalidNumberFormat : null,
                          hint: '6',
                          label: context.locale.swissGamesLabel,
                          controller: swissGamesController,
                        ),
                        const SizedBox(height: 16),
                        DropdownButton<RatingScheme>(
                          items: RatingScheme.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    switch (e) {
                                      RatingScheme.oldFSM => context.locale.old_fsm_schema,
                                      RatingScheme.minusFSM => context.locale.minus_fsm_schema,
                                      RatingScheme.msl => context.locale.msl_schema,
                                      _ => '',
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                          value: ratingScheme,
                          onChanged: (value) {
                            setState(() {
                              ratingScheme = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        IgnorePointer(
                          ignoring: (int.tryParse(swissGamesController.text) ?? 0) == 0,
                          child: Opacity(
                            opacity: (int.tryParse(swissGamesController.text) ?? 0) == 0 ? 0.5 : 1,
                            child: CustomTextField(
                              label: context.locale.bucketFieldTitle,
                              hint: context.locale.bucketFieldHint,
                              readOnly: (int.tryParse(swissGamesController.text) ?? 0) == 0,
                              controller: bucketsController,
                              validate: (value) {
                                if ((int.tryParse(swissGamesController.text) ?? 0) == 0) {
                                  return null;
                                }
                                return (value?.split(';').any(
                                          (element) {
                                            final count = int.tryParse(element);
                                            return count == null || count % 10 > 0;
                                          },
                                        ) ??
                                        true)
                                    ? context.locale.invalidBucketsFormat
                                    : null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: '6',
                                validate: (value) =>
                                    int.tryParse(value ?? '') == null ? context.locale.invalidNumberFormat : null,
                                label: context.locale.finalGamesLabel,
                                controller: finalGamesController,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FinalPlayersDialog.open(
                                  context: context,
                                  initValue: state.finalPlayers,
                                  players: state.tournamentPlayers,
                                ).then((value) {
                                  if (value != null && context.mounted) {
                                    context.read<TournamentPageBloc>().add(
                                          TournamentPageEvent.setFinalPlayers(
                                            players: value,
                                          ),
                                        );
                                  }
                                });
                              },
                              icon: const Icon(Icons.person),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: hideResult,
                              onChanged: (value) {
                                setState(() {
                                  hideResult = value ?? hideResult;
                                });
                              },
                            ),
                            const SizedBox(width: 4),
                            Text(context.locale.hideResult),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          context.locale.fantasyStatusLabel,
                          style: MyTheme.of(context).defaultTextStyle,
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<FantasyStatus>(
                          isExpanded: true,
                          hint: Text(context.locale.fantasyStatusLabel),
                          items: FantasyStatus.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    switch (e) {
                                      FantasyStatus.enabledForSelected =>
                                        context.locale.fantasyStatusEnabledForSelected,
                                      FantasyStatus.enabledForAll => context.locale.fantasyStatusEnabledForAll,
                                      _ => context.locale.fantasyStatusDisabled,
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                          value: fantasyStatus,
                          onChanged: (value) {
                            setState(() {
                              fantasyStatus = value;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: context.locale.save,
                          disabled: formState.currentState?.validate() != true,
                          onTap: () {
                            final newSettings = TournamentSettingsModel(
                              defaultGames: int.parse(defaultGamesController.text),
                              swissGames: int.parse(swissGamesController.text),
                              finalGames: int.parse(finalGamesController.text),
                              buckets: bucketsController.text.split(';').map((e) => int.tryParse(e)).nonNulls.toList(),
                              hideResult: hideResult,
                              ratingScheme: ratingScheme,
                              fantasyStatus: fantasyStatus,
                            );

                            if (newSettings != state.settings) {
                              context.read<TournamentPageBloc>().add(
                                    TournamentPageEvent.updateSettings(
                                      settings: newSettings,
                                    ),
                                  );
                            }

                            context.backOrGoToDefault()();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
