import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

class StartGameInfoForm extends StatefulWidget {
  final int maxGame;
  final VoidCallback onCollapse;

  const StartGameInfoForm({
    super.key,
    required this.maxGame,
    required this.onCollapse,
  });

  @override
  State<StartGameInfoForm> createState() => _StartGameInfoFormState();
}

class _StartGameInfoFormState extends State<StartGameInfoForm> {
  TimeOfDay? selectedTime;
  int? selectedGame;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
            ),
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (time == null || !mounted) return;
              setState(() => selectedTime = time);
            },
            child: Text(
              switch (selectedTime) {
                final TimeOfDay time => DateFormat('HH:mm').format(
                    DateTime.now().copyWith(
                      hour: time.hour,
                      minute: time.minute,
                    ),
                  ),
                _ => locale.local_time_placeholder,
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Theme(
                  data: ThemeData.dark(),
                  child: CustomDropdown<int>(
                    items: List.generate(widget.maxGame, (i) => i + 1),
                    initValue: selectedGame,
                    onChanged: (value) => setState(() => selectedGame = value),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: selectedGame != null
                      ? () {
                          context.read<TournamentPageBloc>().add(
                                TournamentPageEvent.startGameInfo(
                                  game: selectedGame!,
                                  time: selectedTime,
                                ),
                              );
                          widget.onCollapse();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    disabledBackgroundColor: Colors.white24,
                    disabledForegroundColor: Colors.white38,
                  ),
                  child: Text(
                    locale.send,
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
