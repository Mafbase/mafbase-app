import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_content_page/translation_content_state.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_bloc.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/translation_control_event.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_game_selector.dart';
import 'package:seating_generator_web/ui/translation/translation_control_page/widgets/translation_control_player_card.dart';
import 'package:seating_generator_web/utils.dart';

class TranslationControlPage extends StatefulWidget {
  const TranslationControlPage({super.key});

  static final route = GoRoute(
    path: '/translationControl',
    name: 'translation_control',
    builder: (context, state) {
      final tournamentId = int.parse(state.uri.queryParameters['tournamentId'] ?? '');
      final table = int.parse(state.uri.queryParameters['table'] ?? '');
      final key = state.uri.queryParameters['key'] ?? '';

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

class _TranslationControlPageState extends State<TranslationControlPage> with WidgetsBindingObserver {
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
    final theme = MyTheme.of(context);
    return BlocBuilder<TranslationControlBloc, TranslationContentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.background1,
          appBar: AppBar(
            backgroundColor: theme.background2,
            elevation: 0,
            title: Text(
              context.locale.translationControlTitle,
              style: theme.defaultTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Column(
            children: [
              if (state.totalGames > 0)
                TranslationControlGameSelector(
                  game: state.game,
                  totalGames: state.totalGames,
                  onChanged: (index) {
                    context.read<TranslationControlBloc>().add(
                          TranslationControlEvent.selectGame(gameIndex: index),
                        );
                  },
                ),
              Expanded(
                child: state.isNotEmpty()
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return TranslationControlPlayerCard(
                            index: index,
                            nickname: state.nicknames![index],
                            imageUrl: state.images![index],
                            role: state.roles![index],
                            status: state.statuses![index],
                            onRoleChanged: (role) {
                              context.read<TranslationControlBloc>().add(
                                    TranslationControlEvent.changeRole(
                                      index: index,
                                      role: role,
                                    ),
                                  );
                            },
                            onStatusChanged: (status) {
                              context.read<TranslationControlBloc>().add(
                                    TranslationControlEvent.changeStatus(
                                      index: index,
                                      status: status,
                                    ),
                                  );
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          context.locale.translationControlEmpty,
                          style: theme.hintTextStyle,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<TranslationControlBloc>().add(const TranslationControlEvent.pageOpened());
    }
  }
}
