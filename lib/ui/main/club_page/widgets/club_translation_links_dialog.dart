import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/repositories/club_translation_repository.dart';
import 'package:seating_generator_web/feature/translation_links/translation_table_links.dart';
import 'package:seating_generator_web/feature/translation_links/widgets/translation_table_links_row.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/link_actions.dart';
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

  List<TranslationTableLinks> _tables(String key) => [
        for (var table = 1; table <= _tablesCount; table++)
          TranslationTableLinks.club(clubId: widget.clubId, table: table, key: key),
      ];

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
    final tables = _tables(key);

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
          for (final links in tables)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(10, 4, 4, 4),
              decoration: BoxDecoration(
                color: theme.background1,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.borderColor.withValues(alpha: 0.5)),
              ),
              child: TranslationTableLinksRow(links: links),
            ),
          const SizedBox(height: 8),
          CustomButton(
            text: locale.translationCopyAllButton,
            onTap: () => copyLink(
              context,
              translationLinksClipboardText(locale, tables),
              message: locale.translationCopiedSnackbar,
            ),
          ),
        ],
      ),
    );
  }
}
