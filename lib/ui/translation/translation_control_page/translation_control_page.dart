import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/common/widgets/role_picker.dart';
import 'package:seating_generator_web/common/widgets/status_picker.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';

class TranslationControlPage extends StatefulWidget {
  const TranslationControlPage({super.key});

  static final route = GoRoute(
    path: "/translationControl",
    name: "translation_control",
    builder: (context, state) {
      final tournamentId =
          int.parse(state.uri.queryParameters["tournamentId"] ?? "");
      final table = int.parse(state.uri.queryParameters["table"] ?? "");
      final key = state.uri.queryParameters["key"] ?? "";

      return BlocProvider<TranslationControlBloc>(
        create: (context) => TranslationControlBloc(
          params: TranslationContentBlocParams(
            tournamentId: tournamentId,
            table: table,
            key: key,
          ),
          repository: RepositoryFactory.of(context).translationRepository,
        )..add(const TranslationControlEvent.pageOpened()),
        child: const TranslationControlPage(),
      );
    },
  );

  @override
  State<TranslationControlPage> createState() => _TranslationControlPageState();
}

class _TranslationControlPageState extends State<TranslationControlPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationControlBloc, TranslationContentState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CustomDropdown<int>(
                      initValue: state.game,
                      mapToString: (index) =>
                          index == null ? "" : index.toString(),
                      items: List.generate(
                        state.totalGames,
                        (index) => index + 1,
                      ),
                      onChanged: (index) {
                        if (index != null) {
                          context.read<TranslationControlBloc>().add(
                                TranslationControlEvent.selectGame(
                                  gameIndex: index,
                                ),
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
                          Flexible(
                            child: Text("${index + 1}."),
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: RolePicker(
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
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: StatusPicker(
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
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context
          .read<TranslationControlBloc>()
          .add(const TranslationControlEvent.pageOpened());
    }
  }
}
