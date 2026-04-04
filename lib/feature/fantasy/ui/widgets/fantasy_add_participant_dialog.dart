import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_bloc.dart';
import 'package:seating_generator_web/feature/fantasy/ui/fantasy_event.dart';
import 'package:seating_generator_web/utils.dart';

class FantasyAddParticipantDialog {
  FantasyAddParticipantDialog._();

  static Future<void> show(BuildContext context, int tournamentId) async {
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
                Row(
                  children: [
                    const SizedBox(width: 48),
                    Expanded(
                      child: Text(
                        context.locale.fantasyAddParticipant,
                        textAlign: TextAlign.center,
                        style: MyTheme.of(context).headerTextStyle,
                      ),
                    ),
                    const CloseButton(),
                  ],
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
                              tournamentId: tournamentId,
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

    Future.delayed(const Duration(seconds: 1), controller.dispose);
  }
}
