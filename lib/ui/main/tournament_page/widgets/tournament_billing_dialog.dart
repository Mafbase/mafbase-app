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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormField<int>(
                initialValue: widget.playersCount,
                validator: (value) =>
                    (value != null) && value % 10 == 0 && value > 0
                        ? null
                        : "Некорректное значение",
                onSaved: (value) => count = value ?? count,
                builder: (field) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          final value = field.value;
                          if (value != null && value > widget.playersCount) {
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
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${field.value}",
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
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
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Плашки для трансляции",
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
                child: CustomButton(
                  text: 'Оплатить',
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
              ),
            ],
          ),
        ),
      ),
    );
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
