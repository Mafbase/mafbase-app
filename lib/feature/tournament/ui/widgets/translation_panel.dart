import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/design_picker_dialog.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';

class TranslationPanel extends StatefulWidget {
  final int tournamentId;
  final int tablesCount;

  const TranslationPanel({
    super.key,
    required this.tournamentId,
    required this.tablesCount,
  });

  @override
  State<TranslationPanel> createState() => _TranslationPanelState();
}

class _TranslationPanelState extends State<TranslationPanel> {
  late final TranslationRepository _repository;
  late final Future<TranslationKeyModel> _keyFuture;
  DesignModel? _selectedDesign;

  @override
  void initState() {
    super.initState();
    _repository = RepositoryFactory.of(context).translationRepository;
    _keyFuture = _repository.getKey(tournamentId: widget.tournamentId);
  }

  String _buildLink(String root, String path, String key, int table, DesignModel? design) {
    final base = '$root/$path?tournamentId=${widget.tournamentId}&table=$table&key=$key';
    if (design != null) return '$base&design=${design.designKey}';
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<SeatingPageBloc, SeatingPageState, bool>(
          selector: (state) => !state.isLoading && state.games.isEmpty,
          builder: (context, noSeating) =>
              noSeating ? _NoSeatingWarning(tournamentId: widget.tournamentId) : const SizedBox.shrink(),
        ),
        _buildLinks(context),
      ],
    );
  }

  Widget _buildLinks(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return FutureBuilder<TranslationKeyModel>(
      future: _keyFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final data = snapshot.data!;
        final root = kIsWeb && !kDebugMode
            ? '${Uri.base.scheme}://${Uri.base.host}${Uri.base.port != 80 && Uri.base.port != 443 ? ':${Uri.base.port}' : ''}'
            : 'https://mafbase.ru';

        final savedDesign = data.selectedDesignKey != null
            ? data.designs.where((d) => d.designKey == data.selectedDesignKey).firstOrNull
            : null;
        final fallbackDesign =
            data.designs.where((d) => d.designKey == 'mafbase').firstOrNull ?? data.designs.firstOrNull;
        final effectiveDesign = _selectedDesign ?? savedDesign ?? fallbackDesign;
        final key = data.key;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.designs.isNotEmpty) ...[
                Text(
                  locale.translationDesignLabel,
                  style: GoogleFonts.inter(
                    color: Colors.white38,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: const BorderSide(color: Colors.white24),
                      minimumSize: const Size(0, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final designs = data.designs;
                      final currentIndex = effectiveDesign != null
                          ? designs.indexWhere((d) => d.designKey == effectiveDesign.designKey)
                          : 0;
                      final result = await DesignPickerDialog.open(
                        context: context,
                        designs: designs,
                        initialIndex: currentIndex >= 0 ? currentIndex : 0,
                      );
                      if (result != null) {
                        setState(() => _selectedDesign = result);
                        _repository.saveDesign(
                          tournamentId: widget.tournamentId,
                          designKey: result.designKey,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.palette_outlined, size: 15, color: Colors.white70),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            effectiveDesign?.title ?? '',
                            style: GoogleFonts.inter(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.expand_more, size: 15, color: Colors.white38),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    disabledForegroundColor: context.theme.sidebarSectionTitleColor,
                    side: const BorderSide(color: Colors.white24),
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: widget.tablesCount == 0
                      ? null
                      : () {
                          final buffer = StringBuffer();
                          for (var t = 1; t <= widget.tablesCount; t++) {
                            final content = _buildLink(root, 'translation', key, t, effectiveDesign);
                            final control = _buildLink(root, 'translationControl', key, t, effectiveDesign);
                            buffer.writeln(locale.translationCopyAllTable(t));
                            buffer.writeln('${locale.translationContentLink}: $content');
                            buffer.writeln('${locale.translationControlLink}: $control');
                            if (t < widget.tablesCount) buffer.writeln();
                          }
                          Clipboard.setData(ClipboardData(text: buffer.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(locale.translationCopiedSnackbar)),
                          );
                        },
                  icon: const Icon(Icons.copy, size: 16),
                  label: Text(
                    locale.translationCopyAllButton,
                    style: GoogleFonts.inter(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NoSeatingWarning extends StatelessWidget {
  final int tournamentId;

  const _NoSeatingWarning({required this.tournamentId});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final locale = context.locale;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber_rounded, size: 16, color: theme.redColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  locale.translationNoSeatingWarning,
                  style: GoogleFonts.inter(color: theme.redColor, fontSize: 12),
                ),
              ),
            ],
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: theme.sidebarInactiveTextColor,
              textStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Scaffold.maybeOf(context)?.closeEndDrawer();
              context.router.push(SeatingRoute(tournamentId: tournamentId));
            },
            icon: const Icon(Icons.arrow_forward, size: 16),
            iconAlignment: IconAlignment.end,
            label: Text(locale.translationGoToSeating),
          ),
        ],
      ),
    );
  }
}
