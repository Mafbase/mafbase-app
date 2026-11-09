import 'dart:ui' show SemanticsHitTestBehavior;

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

  const OrganizerChecklistInfoSheet({
    super.key,
    required this.title,
    required this.body,
    this.primaryAction,
    this.secondaryAction,
  });

  /// Завершается, когда лист закрыт — кнопкой действия, крестиком или жестом.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<Widget> body,
    OrganizerChecklistInfoSheetAction? primaryAction,
    OrganizerChecklistInfoSheetAction? secondaryAction,
  }) {
    final navigator = Navigator.of(context);
    return navigator.push(
      _InfoSheetRoute(
        sheet: OrganizerChecklistInfoSheet(
          title: title,
          body: body,
          primaryAction: primaryAction,
          secondaryAction: secondaryAction,
        ),
        capturedThemes: InheritedTheme.capture(from: context, to: navigator.context),
        barrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor ?? Colors.black54,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
      mainAxisSize: MainAxisSize.min,
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
        Flexible(
          child: DefaultTextStyle.merge(
            style: theme.defaultTextStyle.copyWith(fontSize: 16, height: 1.4),
            child: ListView.separated(
              shrinkWrap: true,
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

/// Модальный лист снизу. Это [PageRoute], а не PopupRoute: только из него Hero скриншота летит в полноэкранный
/// просмотр.
class _InfoSheetRoute extends PageRoute<void> {
  final OrganizerChecklistInfoSheet sheet;
  final CapturedThemes capturedThemes;

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  _InfoSheetRoute({
    required this.sheet,
    required this.capturedThemes,
    required this.barrierColor,
    required this.barrierLabel,
  });

  ParametricCurve<double> _curve = Easing.legacyDecelerate;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 200);

  @override
  AnimationController createAnimationController() => BottomSheet.createAnimationController(navigator!);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return capturedThemes.wrap(
      // Как в ModalBottomSheetRoute: в вебе с семантикой клик по тексту листа иначе уходит сквозь него на барьер.
      Semantics(
        hitTestBehavior: SemanticsHitTestBehavior.opaque,
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          label: sheet.title,
          explicitChildNodes: true,
          child: ClipRect(
            child: AnimatedBuilder(
              animation: animation,
              builder: (_, child) => CustomSingleChildLayout(
                delegate: _InfoSheetLayout(_curve.transform(animation.value)),
                child: child,
              ),
              child: BottomSheet(
                animationController: controller,
                onClosing: () {
                  if (isCurrent) navigator!.pop();
                },
                onDragStart: (_) => _curve = Curves.linear,
                onDragEnd: (_, {required isClosing}) =>
                    _curve = Split(animation.value, endCurve: Easing.legacyDecelerate),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                constraints: const BoxConstraints(maxWidth: 640),
                builder: (_) => sheet,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoSheetLayout extends SingleChildLayoutDelegate {
  final double progress;

  const _InfoSheetLayout(this.progress);

  static const _maxHeightFactor = 0.9;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight * _maxHeightFactor,
      );

  @override
  Offset getPositionForChild(Size size, Size childSize) => Offset(0, size.height - childSize.height * progress);

  @override
  bool shouldRelayout(_InfoSheetLayout oldDelegate) => progress != oldDelegate.progress;
}
