import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/utils.dart';

class TournamentBillingDialog extends StatefulWidget {
  final int playersCount;
  final bool billedTranslation;

  const TournamentBillingDialog._({
    Key? key,
    required this.playersCount,
    required this.billedTranslation,
  }) : super(key: key);

  @override
  State<TournamentBillingDialog> createState() =>
      _TournamentBillingDialogState();

  static Future<TournamentBillingDialogResult?> open({
    required BuildContext context,
    required int billedPlayers,
    required bool hasTranslation,
  }) =>
      showDialog(
        context: context,
        builder: (context) => TournamentBillingDialog._(
          billedTranslation: hasTranslation,
          playersCount: billedPlayers,
        ),
      );
}

class _TournamentBillingDialogState extends State<TournamentBillingDialog> {
  int count = 10;
  bool enableTranslation = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    count = widget.playersCount;
    enableTranslation = widget.billedTranslation;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Form(
        key: formKey,
        onChanged: () {
          setState(() {
            formKey.currentState?.save();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormField<int>(
                initialValue: widget.playersCount,
                validator: (value) =>
                    (value != null) && value % 10 == 0 && value > 0
                        ? null
                        : "Некорректное значение",
                onSaved: (value) => count = value ?? count,
                builder: (field) {
                  return Wrap(
                    children: [
                      Text(
                        context.locale.playersCount,
                        style: context.theme.defaultTextStyle,
                      ),
                      const SizedBox(width: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              final value = field.value;
                              if (value != null &&
                                  value > widget.playersCount) {
                                field.didChange(value - 10);
                              }
                            },
                            child: const Text(
                              "-",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${field.value}",
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              final value = field.value;
                              if (value != null) {
                                field.didChange(value + 10);
                              }
                            },
                            child: const Text(
                              "+",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              FormField<bool>(
                initialValue: widget.billedTranslation,
                validator: (value) =>
                    value == null ? null : "Некорректное значение",
                onSaved: (value) =>
                    enableTranslation = value ?? enableTranslation,
                builder: (field) {
                  return Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        context.locale.translationHelp,
                        style: context.theme.defaultTextStyle,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Checkbox(
                        value: field.value,
                        onChanged: widget.billedTranslation
                            ? null
                            : (newValue) {
                                field.didChange(newValue);
                              },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                child: Builder(
                  builder: (context) {
                    final price = widget.playersCount != count ||
                            widget.billedTranslation != enableTranslation
                        ? calculatePrice(
                              count,
                              enableTranslation,
                            ) -
                            calculatePrice(
                              widget.playersCount,
                              widget.billedTranslation,
                            )
                        : null;
                    return Center(
                      child: CustomButton(
                        text: 'Оплатить${price == null ? '' : ' $price₽'}',
                        disabled:
                            widget.billedTranslation == enableTranslation &&
                                widget.playersCount == count,
                        onTap: () {
                          formKey.currentState?.save();
                          Navigator.pop(
                            context,
                            TournamentBillingDialogResult(
                              billedTranslation: enableTranslation,
                              billedPlayers: count,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int calculatePrice(int count, bool translation) {
  if (count == 10 && translation) {
    return 300;
  } else if (count == 10) {
    return 0;
  }

  final tens = count ~/ 10;
  if (translation) {
    return tens * 400;
  } else {
    return tens * 300;
  }
}

class TournamentBillingDialogResult {
  final bool billedTranslation;
  final int billedPlayers;

  const TournamentBillingDialogResult({
    required this.billedTranslation,
    required this.billedPlayers,
  });
}
