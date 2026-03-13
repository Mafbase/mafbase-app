import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/models/tournament_settings_model.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pbenum.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentSettingsDialog extends StatefulWidget {
  final int defaultGames;
  final int swissGames;
  final int finalGames;
  final List<int>? buckets;
  final VoidCallback onFinalPlayersTapped;
  final bool hideResult;
  final RatingScheme? scheme;
  final FantasyStatus? fantasyStatus;

  const TournamentSettingsDialog({
    super.key,
    this.defaultGames = 0,
    this.swissGames = 0,
    this.finalGames = 0,
    this.buckets,
    this.hideResult = false,
    this.scheme,
    this.fantasyStatus,
    required this.onFinalPlayersTapped,
  });

  @override
  State<TournamentSettingsDialog> createState() => _TournamentSettingsDialogState();

  static Future<TournamentSettingsModel?> open({
    required BuildContext context,
    required VoidCallback onFinalPlayersTapped,
    required TournamentSettingsModel initValue,
  }) {
    return showDialog(
      context: context,
      builder: (context) => TournamentSettingsDialog(
        defaultGames: initValue.defaultGames,
        swissGames: initValue.swissGames,
        finalGames: initValue.finalGames,
        buckets: initValue.buckets,
        hideResult: initValue.hideResult,
        scheme: initValue.ratingScheme,
        fantasyStatus: initValue.fantasyStatus,
        onFinalPlayersTapped: onFinalPlayersTapped,
      ),
    );
  }
}

class _TournamentSettingsDialogState extends State<TournamentSettingsDialog> {
  final defaultGamesController = TextEditingController();
  final finalGamesController = TextEditingController();
  final swissGamesController = TextEditingController();
  final bucketsController = TextEditingController();
  late bool hideResult = widget.hideResult;
  late RatingScheme? ratingScheme = widget.scheme;
  late FantasyStatus? fantasyStatus = widget.fantasyStatus;

  final formState = GlobalKey<FormState>();

  @override
  void initState() {
    defaultGamesController.text = widget.defaultGames.toString();
    finalGamesController.text = widget.finalGames.toString();
    swissGamesController.text = widget.swissGames.toString();
    bucketsController.text = widget.buckets?.join(';') ?? '';

    Listenable.merge([
      defaultGamesController,
      finalGamesController,
      swissGamesController,
      bucketsController,
    ]).addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });

    super.initState();
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
    return CustomDialog(
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formState,
            onChanged: () {
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.locale.tournamentSettingsTitle,
                    style: MyTheme.of(context).headerTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hint: '6',
                    validate: (value) => int.tryParse(value ?? '') == null ? 'Неверный формат числа' : null,
                    label: context.locale.defaultGamesLabel,
                    controller: defaultGamesController,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    validate: (value) => int.tryParse(value ?? '') == null ? 'Неверный формат числа' : null,
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
                              ? 'Неверный формат корзин'
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
                          validate: (value) => int.tryParse(value ?? '') == null ? 'Неверный формат числа' : null,
                          label: context.locale.finalGamesLabel,
                          controller: finalGamesController,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onFinalPlayersTapped,
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
                                FantasyStatus.enabledForSelected => context.locale.fantasyStatusEnabledForSelected,
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
                  const SizedBox(height: 16),
                  CustomButton(
                    text: context.locale.save,
                    disabled: formState.currentState?.validate() != true,
                    onTap: () {
                      Navigator.of(context).pop(
                        TournamentSettingsModel(
                          defaultGames: int.parse(defaultGamesController.text),
                          swissGames: int.parse(swissGamesController.text),
                          finalGames: int.parse(finalGamesController.text),
                          buckets: bucketsController.text.split(';').map((e) => int.tryParse(e)).nonNulls.toList(),
                          hideResult: hideResult,
                          ratingScheme: ratingScheme,
                          fantasyStatus: fantasyStatus,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
