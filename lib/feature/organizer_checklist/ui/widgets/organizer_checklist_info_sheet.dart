import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:url_launcher/url_launcher.dart';

const organizerChecklistAskQuestionUrl = 'https://vk.ru/strelas70';

/// Кнопка [OrganizerChecklistInfoSheet]: нажатие закрывает лист, затем вызывает [onTap].
class OrganizerChecklistInfoSheetAction {
  final String text;
  final VoidCallback onTap;

  const OrganizerChecklistInfoSheetAction({
    required this.text,
    required this.onTap,
  });
}

/// Лист с пояснением к функции турнира или пункту чеклиста.
class OrganizerChecklistInfoSheet extends StatelessWidget {
  final String title;
  final List<Widget> body;
  final OrganizerChecklistInfoSheetAction? primaryAction;
  final OrganizerChecklistInfoSheetAction? secondaryAction;
  final ScrollController? scrollController;

  const OrganizerChecklistInfoSheet({
    super.key,
    required this.title,
    required this.body,
    this.primaryAction,
    this.secondaryAction,
    this.scrollController,
  });

  /// Завершается, когда лист закрыт — кнопкой действия, крестиком или жестом.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<Widget> body,
    OrganizerChecklistInfoSheetAction? primaryAction,
    OrganizerChecklistInfoSheetAction? secondaryAction,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 640),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, scrollController) => OrganizerChecklistInfoSheet(
          title: title,
          body: body,
          primaryAction: primaryAction,
          secondaryAction: secondaryAction,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _runAction(BuildContext context, OrganizerChecklistInfoSheetAction action) {
    Navigator.pop(context);
    action.onTap();
  }

  static Future<void> _askQuestion() => launchUrl(
        Uri.parse(organizerChecklistAskQuestionUrl),
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: theme.headerTextStyle),
              ),
              const CloseButton(),
            ],
          ),
        ),
        Expanded(
          child: DefaultTextStyle.merge(
            style: theme.defaultTextStyle.copyWith(height: 1.4),
            child: ListView.separated(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              itemCount: body.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) => body[index],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 4,
              children: [
                if (primaryAction case final action?)
                  CustomButton(
                    text: action.text,
                    onTap: () => _runAction(context, action),
                  ),
                if (secondaryAction case final action?)
                  TextButton(
                    onPressed: () => _runAction(context, action),
                    child: Text(action.text),
                  ),
                TextButton.icon(
                  onPressed: _askQuestion,
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: Text(context.locale.checklistSheetAskQuestion),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
