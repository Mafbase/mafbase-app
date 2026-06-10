import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/repositories/club_translation_repository.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

class ClubTranslationLinksDialog {
  ClubTranslationLinksDialog._();

  static Future<void> show(BuildContext context, {required int clubId}) {
    if (!context.isMobile) {
      return showDialog<void>(
        context: context,
        builder: (_) => _ClubTranslationLinksBody(clubId: clubId, isDialog: true),
      );
    }
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ClubTranslationLinksBody(clubId: clubId),
    );
  }
}

class _ClubTranslationLinksBody extends StatefulWidget {
  final int clubId;
  final bool isDialog;

  const _ClubTranslationLinksBody({required this.clubId, this.isDialog = false});

  @override
  State<_ClubTranslationLinksBody> createState() => _ClubTranslationLinksBodyState();
}

class _ClubTranslationLinksBodyState extends State<_ClubTranslationLinksBody> {
  late final ClubTranslationRepository _repository;
  late final Future<String> _keyFuture;
  final TextEditingController _tablesController = TextEditingController(text: '1');
  int _tablesCount = 1;

  @override
  void initState() {
    super.initState();
    _repository = RepositoryFactory.of(context).clubTranslationRepository;
    _keyFuture = _repository.getKey(clubId: widget.clubId);
  }

  @override
  void dispose() {
    _tablesController.dispose();
    super.dispose();
  }

  String _root() {
    if (kIsWeb && !kDebugMode) {
      final port = Uri.base.port != 80 && Uri.base.port != 443 ? ':${Uri.base.port}' : '';
      return '${Uri.base.scheme}://${Uri.base.host}$port';
    }
    return 'https://mafbase.ru';
  }

  String _buildLink(String root, String path, String key, int table) =>
      '$root/$path?clubId=${widget.clubId}&table=$table&key=$key';

  Future<void> _copyAll(String key) async {
    final root = _root();
    final locale = context.locale;
    final buffer = StringBuffer();
    for (var t = 1; t <= _tablesCount; t++) {
      final content = _buildLink(root, 'translation', key, t);
      final control = _buildLink(root, 'translationControl', key, t);
      buffer.writeln(locale.translationCopyAllTable(t));
      buffer.writeln('${locale.translationContentLink}: $content');
      buffer.writeln('${locale.translationControlLink}: $control');
      if (t < _tablesCount) buffer.writeln();
    }
    await Clipboard.setData(ClipboardData(text: buffer.toString()));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(locale.translationCopiedSnackbar)));
  }

  Future<void> _copyOne(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.locale.translationCopiedSnackbar)));
  }

  @override
  Widget build(BuildContext context) {
    final body = FutureBuilder<String>(
      future: _keyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(48),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(context.locale.clubTranslationLinksError, style: MyTheme.of(context).defaultTextStyle),
            ),
          );
        }
        return _buildContent(snapshot.data!);
      },
    );

    if (widget.isDialog) {
      return CustomDialog(
        child: SizedBox(width: 560, child: SingleChildScrollView(child: body)),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => SingleChildScrollView(controller: scrollController, child: body),
    );
  }

  Widget _buildContent(String key) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final root = _root();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            locale.clubTranslationLinksTitle,
            style: theme.defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _tablesController,
            label: locale.clubTranslationTablesCountLabel,
            textInputType: TextInputType.number,
            onChanged: (value) {
              final parsed = int.tryParse(value);
              if (parsed != null && parsed > 0 && parsed != _tablesCount) {
                setState(() => _tablesCount = parsed);
              }
            },
          ),
          const SizedBox(height: 16),
          for (var t = 1; t <= _tablesCount; t++) ...[
            Text(
              locale.translationCopyAllTable(t),
              style: theme.defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            _LinkRow(
              label: locale.translationContentLink,
              link: _buildLink(root, 'translation', key, t),
              onCopy: _copyOne,
            ),
            const SizedBox(height: 6),
            _LinkRow(
              label: locale.translationControlLink,
              link: _buildLink(root, 'translationControl', key, t),
              onCopy: _copyOne,
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 8),
          CustomButton(text: locale.translationCopyAllButton, onTap: () => _copyAll(key)),
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  final String label;
  final String link;
  final ValueChanged<String> onCopy;

  const _LinkRow({required this.label, required this.link, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.background1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.borderColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: theme.defaultTextStyle.copyWith(fontSize: 12, color: theme.darkGreyColor)),
                const SizedBox(height: 2),
                Text(
                  link,
                  style: theme.defaultTextStyle.copyWith(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onCopy(link),
            icon: const Icon(Icons.copy, size: 18),
            tooltip: context.locale.translationCopyAllButton,
            color: theme.hintColor,
          ),
        ],
      ),
    );
  }
}
