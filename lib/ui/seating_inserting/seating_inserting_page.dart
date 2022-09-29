import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_bloc.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_event.dart';
import 'package:seating_generator_web/ui/seating_inserting/seating_inserting_state.dart';

class SeatingInsertingPage extends StatefulWidget {
  const SeatingInsertingPage({Key? key}) : super(key: key);

  @override
  State<SeatingInsertingPage> createState() => _SeatingInsertingPageState();
}

class _SeatingInsertingPageState extends State<SeatingInsertingPage> {
  final _csvController = TextEditingController();
  final _idController = TextEditingController();
  final _idFocus = FocusNode();
  final _csvFocus = FocusNode();

  @override
  void dispose() {
    _csvController.dispose();
    _idController.dispose();
    _idFocus.dispose();
    _csvFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatingInsertingBloc, SeatingInsertingState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      maxLines: 1,
                      minLines: 1,
                      textAlign: TextAlign.center,
                      controller: _idController,
                      decoration: const InputDecoration(
                        hintText: "Идентификатор турнира",
                      ),
                      keyboardType: TextInputType.number,
                      focusNode: _idFocus,
                      onFieldSubmitted: (_) {
                        _csvFocus.requestFocus();
                      },
                    ),
                    TextButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              final bloc = context.read<SeatingInsertingBloc>();
                              final files =
                                  await FilePicker.platform.pickFiles();
                              debugPrint(
                                (files!.files.first.bytes == null).toString(),
                              );
                              debugPrint(files.files.first.name);
                              bloc.add(
                                SeatingInsertingFileSelectedEvent(
                                  bytesStream:
                                      Stream.value(files.files.first.bytes!),
                                ),
                              );
                            },
                      child: const Text("Загрузить файл"),
                    ),
                    TextButton(
                      onPressed: state.isLoading ? null : onSubmit,
                      child: Text(AppLocalizations.of(context)!.send),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void onSubmit() {
    context.read<SeatingInsertingBloc>().add(
          SeatingInsertingEvent.save(
            tournamentId: int.parse(_idController.text),
          ),
        );
  }
}
