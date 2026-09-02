import 'package:flutter/material.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/common/widgets/custom_dialog.dart';
import 'package:seating_generator_web/common/widgets/custom_text_field.dart';
import 'package:seating_generator_web/domain/repositories/stream_repository.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';
import 'package:seating_generator_web/utils/widget_extensions.dart';

/// Overlay-настройки трансляций клуба: картинки-заглушки на перерыве и брендирование.
class ClubStreamSettingsSheet {
  ClubStreamSettingsSheet._();

  static Future<void> show(BuildContext context, {required int clubId}) {
    if (!context.isMobile) {
      return showDialog<void>(
        context: context,
        builder: (_) => _ClubStreamSettingsBody(clubId: clubId, isDialog: true),
      );
    }
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => _ClubStreamSettingsBody(clubId: clubId),
    );
  }
}

class _ClubStreamSettingsBody extends StatefulWidget {
  final int clubId;
  final bool isDialog;

  const _ClubStreamSettingsBody({required this.clubId, this.isDialog = false});

  @override
  State<_ClubStreamSettingsBody> createState() => _ClubStreamSettingsBodyState();
}

class _ClubStreamSettingsBodyState extends State<_ClubStreamSettingsBody> {
  late final StreamRepository _repository;
  late final Future<StreamSettingsOut> _settingsFuture;
  final _breakPlaceholderController = TextEditingController();
  final _brandImageController = TextEditingController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _repository = RepositoryFactory.of(context).streamRepository;
    _settingsFuture = _repository.getClubStreamSettings(clubId: widget.clubId).then((settings) {
      _breakPlaceholderController.text = settings.breakPlaceholderImageUrl;
      _brandImageController.text = settings.brandImageUrl;
      return settings;
    });
  }

  @override
  void dispose() {
    _breakPlaceholderController.dispose();
    _brandImageController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      await _repository.setClubStreamSettings(
        clubId: widget.clubId,
        breakPlaceholderImageUrl: _breakPlaceholderController.text.trim(),
        brandImageUrl: _brandImageController.text.trim(),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final body = FutureBuilder<StreamSettingsOut>(
      future: _settingsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(48),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildContent();
      },
    );

    if (widget.isDialog) {
      return CustomDialog(
        child: SizedBox(width: 480, child: SingleChildScrollView(child: body)),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(child: body),
    );
  }

  Widget _buildContent() {
    final theme = MyTheme.of(context);
    final locale = context.locale;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  locale.clubStreamSettingsTitle,
                  style: theme.defaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const CloseButton(),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _breakPlaceholderController,
            label: locale.clubStreamSettingsBreakPlaceholder,
            hint: 'https://',
            validate: (_) => null,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: _brandImageController,
            label: locale.clubStreamSettingsBrandImage,
            hint: 'https://',
            validate: (_) => null,
          ),
          const SizedBox(height: 24),
          CustomButton(text: locale.clubStreamSettingsSave, onTap: _save, isLoading: _isSaving),
        ],
      ),
    );
  }
}
