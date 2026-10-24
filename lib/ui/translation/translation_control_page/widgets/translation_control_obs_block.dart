import 'package:flutter/material.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_dropdown.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

/// Сворачиваемый блок выбора сцен OBS, на которые оверлей переключается при смене фазы трансляции.
class TranslationControlObsBlock extends StatefulWidget {
  final ObsState? obs;
  final ObsSceneMapping? mapping;
  final ValueChanged<ObsSceneMapping> onMappingChanged;

  const TranslationControlObsBlock({
    super.key,
    required this.obs,
    required this.mapping,
    required this.onMappingChanged,
  });

  @override
  State<TranslationControlObsBlock> createState() => _TranslationControlObsBlockState();
}

enum _ObsStatus { disconnected, noRights, ready }

/// Уровень прав страницы в OBS, с которого разрешено переключать сцены (ADVANCED).
const _sceneSwitchControlLevel = 4;

const _noScene = '';

const _phases = [BroadcastPhase.day, BroadcastPhase.night, BroadcastPhase.break_phase];

_ObsStatus _statusOf(ObsState? obs) {
  if (obs == null || !obs.connected) return _ObsStatus.disconnected;
  if (obs.controlLevel < _sceneSwitchControlLevel) return _ObsStatus.noRights;
  return _ObsStatus.ready;
}

String _sceneFor(ObsSceneMapping? mapping, BroadcastPhase phase) {
  if (mapping == null) return _noScene;
  return switch (phase) {
    BroadcastPhase.night => mapping.night,
    BroadcastPhase.break_phase => mapping.breakPhase,
    _ => mapping.day,
  };
}

bool _isMappingEmpty(ObsSceneMapping? mapping) => _phases.every((phase) => _sceneFor(mapping, phase).isEmpty);

class _TranslationControlObsBlockState extends State<TranslationControlObsBlock> {
  late bool _expanded;

  bool get _defaultExpanded => _statusOf(widget.obs) != _ObsStatus.ready || _isMappingEmpty(widget.mapping);

  @override
  void initState() {
    super.initState();
    _expanded = _defaultExpanded;
  }

  @override
  void didUpdateWidget(covariant TranslationControlObsBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_statusOf(oldWidget.obs) != _statusOf(widget.obs)) {
      _expanded = _defaultExpanded;
    }
  }

  void _onSceneSelected(BroadcastPhase changed, String scene) {
    String? sceneFor(BroadcastPhase phase) {
      final value = phase == changed ? scene : _sceneFor(widget.mapping, phase);
      return value.isEmpty ? null : value;
    }

    widget.onMappingChanged(
      ObsSceneMapping(
        day: sceneFor(BroadcastPhase.day),
        night: sceneFor(BroadcastPhase.night),
        breakPhase: sceneFor(BroadcastPhase.break_phase),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final status = _statusOf(widget.obs);

    return Material(
      color: theme.background2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TranslationControlObsHeader(
            status: status,
            expanded: _expanded,
            onTap: () => setState(() => _expanded = !_expanded),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: _buildBody(context, status),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, _ObsStatus status) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final hintStyle = theme.defaultTextStyle.copyWith(color: theme.darkGreyColor);
    final obs = widget.obs;

    if (status == _ObsStatus.ready && obs != null) {
      final currentScene = obs.hasCurrentScene() ? obs.currentScene : _noScene;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final phase in _phases)
            _TranslationControlObsSceneRow(
              phase: phase,
              scene: _sceneFor(widget.mapping, phase),
              availableScenes: obs.scenes,
              onChanged: (scene) => _onSceneSelected(phase, scene),
            ),
          if (currentScene.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(locale.translationControlObsCurrentScene(currentScene), style: hintStyle),
            ),
        ],
      );
    }

    final hint = status == _ObsStatus.noRights
        ? locale.translationControlObsNoRightsHint
        : locale.translationControlObsDisconnectedHint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: hintStyle),
        if (!_isMappingEmpty(widget.mapping)) ...[
          const SizedBox(height: 8),
          for (final phase in _phases)
            _TranslationControlObsSceneRow(phase: phase, scene: _sceneFor(widget.mapping, phase)),
        ],
      ],
    );
  }
}

class _TranslationControlObsHeader extends StatelessWidget {
  final _ObsStatus status;
  final bool expanded;
  final VoidCallback onTap;

  const _TranslationControlObsHeader({required this.status, required this.expanded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final (color, text) = switch (status) {
      _ObsStatus.disconnected => (theme.statusEndedColor, locale.translationControlObsDisconnected),
      _ObsStatus.noRights => (theme.statusBillingColor, locale.translationControlObsNoRights),
      _ObsStatus.ready => (theme.successColor, locale.translationControlObsConnected),
    };

    return Semantics(
      button: true,
      expanded: expanded,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(border: Border(top: BorderSide(color: theme.borderColor, width: 0.5))),
          child: Row(
            children: [
              Text(
                locale.translationControlObsTitle,
                style: theme.defaultTextStyle.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 12),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(text, style: theme.defaultTextStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              Icon(expanded ? Icons.expand_less : Icons.expand_more, color: theme.darkGreyColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// Строка «фаза → сцена». Без [availableScenes] показывает сохранённую сцену только для чтения.
class _TranslationControlObsSceneRow extends StatelessWidget {
  final BroadcastPhase phase;
  final String scene;
  final List<String>? availableScenes;
  final ValueChanged<String>? onChanged;

  const _TranslationControlObsSceneRow({
    required this.phase,
    required this.scene,
    this.availableScenes,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    final locale = context.locale;
    final available = availableScenes;
    final items = available == null ? [scene] : {_noScene, ...available.where((s) => s.isNotEmpty), scene}.toList();

    String label(String? item) {
      if (item == null || item.isEmpty) return locale.translationControlObsNoSwitch;
      if (available == null || available.contains(item)) return item;
      return locale.translationControlObsMissingScene(item);
    }

    final phaseLabel = switch (phase) {
      BroadcastPhase.night => locale.translationControlPhaseNight,
      BroadcastPhase.break_phase => locale.translationControlPhaseBreak,
      _ => locale.translationControlPhaseDay,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 88, child: Text(phaseLabel, style: theme.defaultTextStyle)),
          Expanded(
            child: CustomDropdown<String>(
              // CustomDropdown держит выбор в своём состоянии; если список сцен сменился раньше, чем пришло
              // сохранённое значение, выбора может не оказаться в items, и DropdownButton падает на assert.
              key: ValueKey(items.join('\n')),
              items: items,
              initValue: scene,
              readOnly: available == null,
              mapToString: label,
              onChanged: (value) {
                if (value != null && value != scene) onChanged?.call(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
