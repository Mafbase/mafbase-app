import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_event.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_state.dart';
import 'package:seating_generator_web/utils.dart';

class SeatingInsertingPage extends StatefulWidget {
  const SeatingInsertingPage({super.key});

  static const name = 'fsm_seating';
  static final route = GoRoute(
    name: name,
    path: 'fsmSeating',
    builder: (context, state) {
      final id = int.parse(state.pathParameters['id']!);
      return BlocProvider<SeatingInsertingBloc>(
        create: (context) => SeatingInsertingBloc(
          router: SeatingInsertingRouterImpl(context),
          repos: RepositoryFactory.of(context),
          tournamentId: id,
        ),
        child: const SeatingInsertingPage(),
      );
    },
  );

  static String createLocation(BuildContext context, int id) {
    return context.namedLocation(
      name,
      pathParameters: {'id': id.toString()},
    );
  }

  @override
  State<SeatingInsertingPage> createState() => _SeatingInsertingPageState();
}

class _SeatingInsertingPageState extends State<SeatingInsertingPage> {
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatingInsertingBloc, SeatingInsertingState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  context.locale.fsmSeatingHeader,
                  style: MyTheme.of(context).headerTextStyle,
                ),
                TextButton(
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          final bloc = context.read<SeatingInsertingBloc>();
                          final files = await FilePicker.platform.pickFiles();
                          bloc.add(
                            SeatingInsertingFileSelectedEvent(
                              bytesStream: Stream.value(
                                files!.files.first.bytes!,
                              ),
                            ),
                          );
                          setState(() {
                            name = files.files.first.name;
                          });
                        },
                  child: Text(
                    name ?? 'Загрузить файл',
                    style: MyTheme.of(context).textBtnTextStyle,
                  ),
                ),
                CustomButton(
                  onTap: onSubmit,
                  disabled: state.isLoading,
                  text: AppLocalizations.of(context)!.send,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onSubmit() {
    context.read<SeatingInsertingBloc>().add(
          const SeatingInsertingEvent.save(),
        );
  }
}
