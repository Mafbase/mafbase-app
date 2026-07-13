// Вендоренная (скопированная) версия Flutter-виджета `RawAutocomplete`.
//
// Источник: Flutter SDK 3.41.3 (channel stable, revision 48c32af034),
//   packages/flutter/lib/src/widgets/autocomplete.dart
//   https://github.com/flutter/flutter/blob/stable/packages/flutter/lib/src/widgets/autocomplete.dart
// Дата копирования: 2026-07-12.
// Лицензия оригинала: BSD-3-Clause (Copyright 2014 The Flutter Authors).
//
// Зачем скопировано:
//   У штатного `RawAutocomplete` нет публичного API для сброса индекса
//   подсвеченной клавиатурой опции. При обновлении списка опций из-за нового
//   ввода индекс сохранялся (пересчитывался как clamp старого значения), из-за
//   чего при переиспользовании виджета подсветка «залипала» на прежней позиции.
//   Ранее пробовали сбрасывать через смену `key`, но это пересоздавало
//   `EditableText` и роняло фокус поля. Поэтому виджет вендорен, чтобы поправить
//   ровно одну строку без пересоздания поля.
//
// НАША МОДИФИКАЦИЯ (единственное отличие от оригинала):
//   В обработчике изменения текста поля `_onChangedField` вызов
//     _updateHighlight(_highlightedOptionIndex.value);
//   заменён на
//     _updateHighlight(0); // patched: сброс подсветки на верхнюю опцию
//   Таким образом при каждом новом вводе подсвечивается верхняя опция.
//   Клавиатурная навигация стрелками (_highlightPrevious/Next и т.п.) не тронута.
//
// Всё, что публично экспортируется Flutter (типы `OptionsViewOpenDirection`,
// `AutocompleteHighlightedOption`, Intent-классы, typedef'ы билдеров),
// НЕ копируется, а переиспользуется из `package:flutter/widgets.dart` — чтобы
// не плодить конфликтующие дубликаты. Скопированы только приватный
// `_AutocompleteCallbackAction` (недоступен извне) и сам класс/стейт
// (переименованы в `PatchedRawAutocomplete` / `_PatchedRawAutocompleteState`).
//
// При апгрейде Flutter SDK: пересинхронизировать этот файл с новым
// autocomplete.dart и заново применить модификацию из блока выше.

import 'dart:async';
import 'dart:math' as math show max;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show kMinInteractiveDimension;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Копия приватного `_AutocompleteCallbackAction` из Flutter SDK.
///
/// Недоступен из публичного API, поэтому скопирован без изменений.
class _AutocompleteCallbackAction<T extends Intent> extends CallbackAction<T> {
  _AutocompleteCallbackAction({required super.onInvoke, required this.isEnabledCallback});

  // The enabled state determines whether the action will consume the
  // key shortcut or let it continue on to the underlying text field.
  // They should only be enabled when the options are showing so shortcuts
  // can be used to navigate them.
  final bool Function() isEnabledCallback;

  @override
  bool isEnabled(covariant T intent) => isEnabledCallback();

  @override
  bool consumesKey(covariant T intent) => isEnabled(intent);
}

/// Пропатченная копия `RawAutocomplete` из Flutter SDK.
///
/// Публичный API идентичен оригиналу (те же параметры конструктора и
/// дженерик `<T extends Object>`). Единственное отличие в реализации —
/// сброс подсвеченной опции на верхнюю при новом вводе (см. шапку файла).
class PatchedRawAutocomplete<T extends Object> extends StatefulWidget {
  /// Create an instance of PatchedRawAutocomplete.
  ///
  /// [displayStringForOption], [optionsBuilder] and [optionsViewBuilder] must
  /// not be null.
  const PatchedRawAutocomplete({
    super.key,
    required this.optionsViewBuilder,
    required this.optionsBuilder,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.displayStringForOption = defaultStringForOption,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.textEditingController,
    this.initialValue,
  })  : assert(
          fieldViewBuilder != null || (key != null && focusNode != null && textEditingController != null),
          'Pass in a fieldViewBuilder, or otherwise create a separate field and pass in the FocusNode, TextEditingController, and a key. Use the key with PatchedRawAutocomplete.onFieldSubmitted.',
        ),
        assert((focusNode == null) == (textEditingController == null)),
        assert(
          !(textEditingController != null && initialValue != null),
          'textEditingController and initialValue cannot be simultaneously defined.',
        );

  /// {@macro flutter.widgets.RawAutocomplete.fieldViewBuilder}
  final AutocompleteFieldViewBuilder? fieldViewBuilder;

  /// The [FocusNode] that is used for the text field.
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewBuilder}
  final AutocompleteOptionsViewBuilder<T> optionsViewBuilder;

  /// {@macro flutter.widgets.RawAutocomplete.optionsViewOpenDirection}
  final OptionsViewOpenDirection optionsViewOpenDirection;

  /// {@macro flutter.widgets.RawAutocomplete.displayStringForOption}
  final AutocompleteOptionToString<T> displayStringForOption;

  /// {@macro flutter.widgets.RawAutocomplete.onSelected}
  final AutocompleteOnSelected<T>? onSelected;

  /// {@macro flutter.widgets.RawAutocomplete.optionsBuilder}
  final AutocompleteOptionsBuilder<T> optionsBuilder;

  /// The [TextEditingController] that is used for the text field.
  final TextEditingController? textEditingController;

  /// {@macro flutter.widgets.RawAutocomplete.initialValue}
  final TextEditingValue? initialValue;

  /// Calls [AutocompleteFieldViewBuilder]'s onFieldSubmitted callback for the
  /// PatchedRawAutocomplete widget indicated by the given [GlobalKey].
  static void onFieldSubmitted<T extends Object>(GlobalKey key) {
    final rawAutocomplete = key.currentState! as _PatchedRawAutocompleteState<T>;
    rawAutocomplete._onFieldSubmitted();
  }

  /// The default way to convert an option to a string in
  /// [displayStringForOption].
  ///
  /// Uses the `toString` method of the given `option`.
  static String defaultStringForOption(Object? option) {
    return option.toString();
  }

  @override
  State<PatchedRawAutocomplete<T>> createState() => _PatchedRawAutocompleteState<T>();
}

class _PatchedRawAutocompleteState<T extends Object> extends State<PatchedRawAutocomplete<T>> {
  final OverlayPortalController _optionsViewController = OverlayPortalController(
    debugLabel: '_PatchedRawAutocompleteState',
  );

  // The number of options to scroll by "page", such as when using the page
  // up/down keys.
  static const int _pageSize = 4;

  /// Whether the field currently has focus.
  ///
  /// This is used to determine whether the focus state has changed.
  late bool _hasFocus;

  /// Whether an option is currently being selected.
  bool _selecting = false;

  TextEditingController? _internalTextEditingController;
  TextEditingController get _textEditingController {
    return widget.textEditingController ??
        (_internalTextEditingController ??= TextEditingController()..addListener(_onChangedField));
  }

  FocusNode? _internalFocusNode;
  FocusNode get _focusNode {
    return widget.focusNode ?? (_internalFocusNode ??= FocusNode()..addListener(_onFocusChange));
  }

  late final Map<Type, CallbackAction<Intent>> _actionMap = <Type, CallbackAction<Intent>>{
    AutocompletePreviousOptionIntent: _AutocompleteCallbackAction<AutocompletePreviousOptionIntent>(
      onInvoke: _highlightPreviousOption,
      isEnabledCallback: () => _canShowOptionsView,
    ),
    AutocompleteNextOptionIntent: _AutocompleteCallbackAction<AutocompleteNextOptionIntent>(
      onInvoke: _highlightNextOption,
      isEnabledCallback: () => _canShowOptionsView,
    ),
    AutocompleteFirstOptionIntent: _AutocompleteCallbackAction<AutocompleteFirstOptionIntent>(
      onInvoke: _highlightFirstOption,
      isEnabledCallback: () => _canShowOptionsView,
    ),
    AutocompleteLastOptionIntent: _AutocompleteCallbackAction<AutocompleteLastOptionIntent>(
      onInvoke: _highlightLastOption,
      isEnabledCallback: () => _canShowOptionsView,
    ),
    AutocompleteNextPageOptionIntent: _AutocompleteCallbackAction<AutocompleteNextPageOptionIntent>(
      onInvoke: _highlightNextPageOption,
      isEnabledCallback: () => _canShowOptionsView,
    ),
    AutocompletePreviousPageOptionIntent: _AutocompleteCallbackAction<AutocompletePreviousPageOptionIntent>(
      onInvoke: _highlightPreviousPageOption,
      isEnabledCallback: () => _canShowOptionsView,
    ),
    DismissIntent: CallbackAction<DismissIntent>(onInvoke: _hideOptions),
  };

  Iterable<T> _options = Iterable<T>.empty();
  T? _selection;
  // Set the initial value to null so when this widget gets focused for the first
  // time it will try to run the options view builder.
  String? _lastFieldText;
  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  static const Map<ShortcutActivator, Intent> _appleShortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp, meta: true): AutocompleteFirstOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown, meta: true): AutocompleteLastOptionIntent(),
  };

  static const Map<ShortcutActivator, Intent> _nonAppleShortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp, control: true): AutocompleteFirstOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown, control: true): AutocompleteLastOptionIntent(),
  };

  static const Map<ShortcutActivator, Intent> _commonShortcuts = <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp): AutocompletePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown): AutocompleteNextOptionIntent(),
    SingleActivator(LogicalKeyboardKey.pageUp): AutocompletePreviousPageOptionIntent(),
    SingleActivator(LogicalKeyboardKey.pageDown): AutocompleteNextPageOptionIntent(),
  };

  static Map<ShortcutActivator, Intent> get _shortcuts => <ShortcutActivator, Intent>{
        ..._commonShortcuts,
        ...switch (defaultTargetPlatform) {
          TargetPlatform.iOS => _appleShortcuts,
          TargetPlatform.macOS => _appleShortcuts,
          TargetPlatform.android => _nonAppleShortcuts,
          TargetPlatform.linux => _nonAppleShortcuts,
          TargetPlatform.windows => _nonAppleShortcuts,
          TargetPlatform.fuchsia => _nonAppleShortcuts,
        },
      };

  /// The options view is considered eligible to show only while the field has
  /// focus and there is at least one option to display.
  bool get _canShowOptionsView => _focusNode.hasFocus && _options.isNotEmpty;

  void _onFocusChange() {
    if (_focusNode.hasFocus != _hasFocus) {
      _hasFocus = _focusNode.hasFocus;
      // Gaining focus can open the options view (if there are options). Losing
      // focus always closes it.
      _updateOptionsViewVisibility();
    }
  }

  /// Shows the options view when the field is focused and there is at least one
  /// option to display; otherwise hides the options view.
  void _updateOptionsViewVisibility() {
    if (_canShowOptionsView) {
      _optionsViewController.show();
    } else {
      _optionsViewController.hide();
    }
  }

  void _announceSemantics(bool resultsAvailable) {
    if (!MediaQuery.supportsAnnounceOf(context)) {
      return;
    }
    final WidgetsLocalizations localizations = WidgetsLocalizations.of(context);
    final String optionsHint = resultsAvailable ? localizations.searchResultsFound : localizations.noResultsFound;
    // ignore: deprecated_member_use — сохраняем поведение оригинала из SDK.
    SemanticsService.announce(optionsHint, localizations.textDirection);
  }

  // Assigning an ID to every call of _onChangedField is necessary to avoid a
  // situation where _options is updated by an older call when multiple
  // _onChangedField calls are running simultaneously.
  int _onChangedCallId = 0;
  // Called when _textEditingController changes.
  Future<void> _onChangedField() async {
    // During a selection, changes to the field text should not trigger
    // options update.
    if (_selecting) {
      return;
    }
    final TextEditingValue value = _textEditingController.value;

    // Makes sure that options change only when content of the field changes.
    var shouldUpdateOptions = false;
    if (value.text != _lastFieldText) {
      shouldUpdateOptions = true;
      _onChangedCallId += 1;
    }
    _lastFieldText = value.text;
    final int callId = _onChangedCallId;
    final Iterable<T> options = await widget.optionsBuilder(value);

    // Makes sure that previous call results do not replace new ones.
    if (callId != _onChangedCallId || !shouldUpdateOptions) {
      return;
    }
    if (_options.isEmpty != options.isEmpty) {
      _announceSemantics(options.isNotEmpty);
    }
    _options = options;
    // patched: сброс подсветки на верхнюю опцию при новом вводе текста.
    // Оригинал: _updateHighlight(_highlightedOptionIndex.value);
    _updateHighlight(0);
    final T? selection = _selection;
    if (selection != null && value.text != widget.displayStringForOption(selection)) {
      _selection = null;
    }

    _updateOptionsViewVisibility();
  }

  // Called from fieldViewBuilder when the user submits the field.
  void _onFieldSubmitted() {
    if (_optionsViewController.isShowing) {
      _select(_options.elementAt(_highlightedOptionIndex.value));
    }
  }

  // Select the given option and update the widget.
  void _select(T nextSelection) {
    if (nextSelection == _selection) {
      return;
    }
    _selecting = true;
    _selection = nextSelection;
    final String selectionString = widget.displayStringForOption(nextSelection);
    _textEditingController.value = TextEditingValue(
      selection: TextSelection.collapsed(offset: selectionString.length),
      text: selectionString,
    );
    widget.onSelected?.call(nextSelection);
    if (_optionsViewController.isShowing) {
      _optionsViewController.hide(); // Close the options view after a selection is made.
    }
    _selecting = false;
  }

  void _updateHighlight(int nextIndex) {
    _highlightedOptionIndex.value = _options.isEmpty ? 0 : nextIndex.clamp(0, _options.length - 1);
  }

  void _highlightPreviousOption(AutocompletePreviousOptionIntent intent) {
    _highlightOption(_highlightedOptionIndex.value - 1);
  }

  void _highlightNextOption(AutocompleteNextOptionIntent intent) {
    _highlightOption(_highlightedOptionIndex.value + 1);
  }

  void _highlightFirstOption(AutocompleteFirstOptionIntent intent) {
    _highlightOption(0);
  }

  void _highlightLastOption(AutocompleteLastOptionIntent intent) {
    _highlightOption(_options.length - 1);
  }

  void _highlightNextPageOption(AutocompleteNextPageOptionIntent intent) {
    _highlightOption(_highlightedOptionIndex.value + _pageSize);
  }

  void _highlightPreviousPageOption(AutocompletePreviousPageOptionIntent intent) {
    _highlightOption(_highlightedOptionIndex.value - _pageSize);
  }

  void _highlightOption(int index) {
    assert(_canShowOptionsView);
    _updateOptionsViewVisibility();
    assert(_optionsViewController.isShowing);
    _updateHighlight(index);
  }

  Object? _hideOptions(DismissIntent intent) {
    if (_optionsViewController.isShowing) {
      _optionsViewController.hide();
      return null;
    } else {
      return Actions.invoke(context, intent);
    }
  }

  // A big enough height for about one item in the default
  // Autocomplete.optionsViewBuilder. The assumption is that the user likely
  // wants the list of options to move to stay on the screen rather than get any
  // smaller than this. Allows Autocomplete to work when it has very little
  // screen height available (as in b/317115348) by positioning itself on top of
  // the field, while in other cases to size itself based on the height under
  // the field.
  static const double _kMinUsableHeight = kMinInteractiveDimension;

  Widget _buildOptionsView(BuildContext context, OverlayChildLayoutInfo layoutInfo) {
    if (layoutInfo.childPaintTransform.determinant() == 0.0) {
      // The child is not visible.
      return const SizedBox.shrink();
    }
    final Size fieldSize = layoutInfo.childSize;
    final Matrix4 invertTransform = layoutInfo.childPaintTransform.clone()..invert();

    // This may not work well if the paint transform has rotation in it.
    // MatrixUtils.transformRect returns the bounding rect of the rotated overlay
    // rect.
    final Rect overlayRectInField = MatrixUtils.transformRect(invertTransform, Offset.zero & layoutInfo.overlaySize);

    final double spaceAbove = -overlayRectInField.top;
    final double spaceBelow = overlayRectInField.bottom - fieldSize.height;
    final bool opensUp = switch (widget.optionsViewOpenDirection) {
      OptionsViewOpenDirection.up => true,
      OptionsViewOpenDirection.down => false,
      OptionsViewOpenDirection.mostSpace => spaceAbove > spaceBelow,
    };

    final double optionsViewMaxHeight =
        opensUp ? -overlayRectInField.top : overlayRectInField.bottom - fieldSize.height;

    final optionsViewBoundingBox = Size(fieldSize.width, math.max(optionsViewMaxHeight, _kMinUsableHeight));

    final double originY = opensUp ? overlayRectInField.top : overlayRectInField.bottom - optionsViewBoundingBox.height;

    final Matrix4 transform = layoutInfo.childPaintTransform.clone()..translateByDouble(0.0, originY, 0, 1);
    final Widget child = Builder(
      builder: (BuildContext context) => widget.optionsViewBuilder(context, _select, _options),
    );
    return Transform(
      transform: transform,
      child: Align(
        alignment: Alignment.topLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints.tight(optionsViewBoundingBox),
          child: Align(
            alignment: opensUp ? AlignmentDirectional.bottomStart : AlignmentDirectional.topStart,
            child: TextFieldTapRegion(
              child: AutocompleteHighlightedOption(highlightIndexNotifier: _highlightedOptionIndex, child: child),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final TextEditingController initialController = widget.textEditingController ??
        (_internalTextEditingController = TextEditingController.fromValue(widget.initialValue));
    initialController.addListener(_onChangedField);
    _hasFocus = _focusNode.hasFocus;
    widget.focusNode?.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(PatchedRawAutocomplete<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.textEditingController, widget.textEditingController)) {
      oldWidget.textEditingController?.removeListener(_onChangedField);
      if (oldWidget.textEditingController == null) {
        _internalTextEditingController?.dispose();
        _internalTextEditingController = null;
      }
      widget.textEditingController?.addListener(_onChangedField);
    }
    if (!identical(oldWidget.focusNode, widget.focusNode)) {
      oldWidget.focusNode?.removeListener(_updateOptionsViewVisibility);
      if (oldWidget.focusNode == null) {
        _internalFocusNode?.dispose();
        _internalFocusNode = null;
      }
      widget.focusNode?.addListener(_updateOptionsViewVisibility);
    }
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_onChangedField);
    _internalTextEditingController?.dispose();
    widget.focusNode?.removeListener(_updateOptionsViewVisibility);
    _internalFocusNode?.dispose();
    _highlightedOptionIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget fieldView =
        widget.fieldViewBuilder?.call(context, _textEditingController, _focusNode, _onFieldSubmitted) ??
            // Horizontally expand to make sure the options view's width won't be zero.
            const SizedBox(width: double.infinity, height: 0.0);
    return OverlayPortal.overlayChildLayoutBuilder(
      controller: _optionsViewController,
      overlayChildBuilder: _buildOptionsView,
      child: TextFieldTapRegion(
        child: Shortcuts(
          shortcuts: _shortcuts,
          child: Actions(actions: _actionMap, child: fieldView),
        ),
      ),
    );
  }
}
