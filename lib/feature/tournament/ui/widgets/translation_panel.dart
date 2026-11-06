import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/design_picker_dialog.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/feature/translation_links/widgets/translation_table_links_row.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_bloc.dart';
import 'package:seating_generator_web/ui/main/seating_page/seating_page_state.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';

class TranslationPanel extends StatefulWidget {
  final int tournamentId;
  final int tablesCount;
  final TranslationLinksFont font;

  const TranslationPanel({
    super.key,
    required this.tournamentId,
    required this.tablesCount,
    this.font = GoogleFonts.inter,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocSelector<SeatingPageBloc, SeatingPageState, bool>(
          selector: (state) => !state.isLoading && state.games.isEmpty,
          builder: (context, noSeating) => noSeating
              ? _NoSeatingWarning(tournamentId: widget.tournamentId, font: widget.font)
              : const SizedBox.shrink(),
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
        final savedDesign = data.selectedDesignKey != null
            ? data.designs.where((d) => d.designKey == data.selectedDesignKey).firstOrNull
            : null;
        final fallbackDesign =
            data.designs.where((d) => d.designKey == 'mafbase').firstOrNull ?? data.designs.firstOrNull;
        final effectiveDesign = _selectedDesign ?? savedDesign ?? fallbackDesign;
        final tables = [
          for (var table = 1; table <= widget.tablesCount; table++)
            TranslationTableLinks.tournament(
              tournamentId: widget.tournamentId,
              table: table,
              key: data.key,
              designKey: effectiveDesign?.designKey,
            ),
        ];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.designs.isNotEmpty) ...[
                Text(
                  locale.translationDesignLabel,
                  style: widget.font(
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
                            style: widget.font(fontSize: 12),
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
                  onPressed: tables.isEmpty
                      ? null
                      : () => copyLink(
                            context,
                            translationLinksClipboardText(locale, tables),
                            message: locale.translationCopiedSnackbar,
                          ),
                  icon: const Icon(Icons.copy, size: 16),
                  label: Text(
                    locale.translationCopyAllButton,
                    style: widget.font(fontSize: 12),
                  ),
                ),
              ),
              if (tables.isNotEmpty) ...[
                const SizedBox(height: 8),
                _TablesLinks(tables: tables, font: widget.font),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TablesLinks extends StatefulWidget {
  final List<TranslationTableLinks> tables;
  final TranslationLinksFont font;

  const _TablesLinks({required this.tables, required this.font});

  @override
  State<_TablesLinks> createState() => _TablesLinksState();
}

class _TablesLinksState extends State<_TablesLinks> {
  static const _maxExpandedTables = 4;

  late bool _expanded = widget.tables.length <= _maxExpandedTables;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final rows = [
      for (final links in widget.tables)
        TranslationTableLinksRow(
          links: links,
          font: widget.font,
          foregroundColor: theme.sidebarInactiveTextColor,
        ),
    ];

    if (widget.tables.length <= _maxExpandedTables) {
      return Column(spacing: 4, children: rows);
    }

    return Column(
      spacing: 4,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    context.locale.translationTablesLinks,
                    style: widget.font(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.sidebarInactiveTextColor,
                    ),
                  ),
                ),
                Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  size: 18,
                  color: theme.sidebarInactiveTextColor,
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...rows,
      ],
    );
  }
}

class _NoSeatingWarning extends StatelessWidget {
  final int tournamentId;
  final TranslationLinksFont font;

  const _NoSeatingWarning({required this.tournamentId, required this.font});

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
                  style: font(color: theme.redColor, fontSize: 12),
                ),
              ),
            ],
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: theme.sidebarInactiveTextColor,
              textStyle: font(fontSize: 12, fontWeight: FontWeight.w600),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Scaffold.maybeOf(context)?.closeEndDrawer();
              context.router.navigate(SeatingRoute(tournamentId: tournamentId));
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
