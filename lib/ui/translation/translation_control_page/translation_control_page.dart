import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/get_it_register.dart';
import 'package:seating_generator_web/common/widgets/role_picker.dart';
import 'package:seating_generator_web/common/widgets/status_picker.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';

class TranslationControlPage extends StatefulWidget {
  const TranslationControlPage({Key? key}) : super(key: key);

  static final route = GoRoute(
    path: "/translationControl",
    name: "translation_control",
    builder: (context, state) {
      final tournamentId = int.parse(state.queryParams["tournamentId"] ?? "");
      final table = int.parse(state.queryParams["table"] ?? "");
      return BlocProvider<TranslationControlBloc>(
        create: (context) => getIt(
          param1: context,
          param2: TranslationContentBlocParams(
            tournamentId: tournamentId,
            table: table,
          ),
        ),
        child: const TranslationControlPage(),
      );
    },
  );

  @override
  State<TranslationControlPage> createState() => _TranslationControlPageState();
}

class _TranslationControlPageState extends State<TranslationControlPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationControlBloc, TranslationContentState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: DropdownButton<int>(
                    value: state.game,
                    items: List.generate(
                      state.totalGames,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text((index + 1).toString()),
                      ),
                    ),
                    onChanged: (index) {
                      if (index != null) {
                        context.read<TranslationControlBloc>().add(
                              TranslationControlEvent.selectGame(gameIndex: index),
                            );
                      }
                    },
                  ),
                ),
                if (state.isNotEmpty())
                  ...List.generate(
                    10,
                    (index) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(state.nicknames![index]),
                        ),
                        RolePicker(
                          playerRole: state.roles![index],
                          onChange: (role) {
                            context.read<TranslationControlBloc>().add(
                                  TranslationControlEvent.changeRole(
                                    index: index,
                                    role: role,
                                  ),
                                );
                          },
                          readOnly: false,
                        ),
                        StatusPicker(
                          playerStatus: state.statuses![index],
                          onChange: (status) {
                            context.read<TranslationControlBloc>().add(
                                  TranslationControlEvent.changeStatus(
                                    index: index,
                                    status: status,
                                  ),
                                );
                          },
                          readOnly: false,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
