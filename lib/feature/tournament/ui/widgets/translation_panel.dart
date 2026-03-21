import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/domain/models/translation_key_model.dart';
import 'package:seating_generator_web/domain/repositories/translation_repository.dart';
import 'package:seating_generator_web/feature/tournament/ui/widgets/design_picker_dialog.dart';
import 'package:seating_generator_web/l10n/app_localizations.dart';

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

        final defaultDesign =
            data.designs.where((d) => d.designKey == 'mafbase').firstOrNull ?? data.designs.firstOrNull;
        final effectiveDesign = _selectedDesign ?? defaultDesign;
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
                    side: const BorderSide(color: Colors.white24),
                    minimumSize: const Size(0, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
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
