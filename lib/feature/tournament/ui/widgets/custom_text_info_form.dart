import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_bloc.dart';
import 'package:seating_generator_web/feature/tournament/ui/tournament_page_event.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

class CustomTextInfoForm extends StatefulWidget {
  final VoidCallback onCollapse;

  const CustomTextInfoForm({
    super.key,
    required this.onCollapse,
  });

  @override
  State<CustomTextInfoForm> createState() => _CustomTextInfoFormState();
}

class _CustomTextInfoFormState extends State<CustomTextInfoForm> {
  final controller = TextEditingController();
  final _focusNode = FocusNode();
  final _fieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = _fieldKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 200),
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            key: _fieldKey,
            controller: controller,
            focusNode: _focusNode,
            maxLines: 3,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              hintText: locale.tournamentMenuTextNotification,
              hintStyle: GoogleFonts.inter(
                color: Colors.white38,
                fontSize: 13,
              ),
              filled: true,
              fillColor: Colors.white10,
              contentPadding: const EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white54),
              ),
            ),
          ),
          const SizedBox(height: 8),
          ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return ElevatedButton(
                onPressed: controller.text.isNotEmpty
                    ? () {
                        context.read<TournamentPageBloc>().add(
                              TournamentPageEvent.customTextInfo(
                                text: controller.text,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
