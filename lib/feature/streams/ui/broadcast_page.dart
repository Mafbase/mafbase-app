import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mafbase_stream/mafbase_stream.dart';
import 'package:seating_generator_web/app/di/repository_factory.dart';
import 'package:seating_generator_web/app/router.dart';
import 'package:seating_generator_web/common/theme/my_theme.dart';
import 'package:seating_generator_web/common/widgets/custom_button.dart';
import 'package:seating_generator_web/feature/streams/data/requests/get_broadcast_credentials_request.dart';
import 'package:seating_generator_web/seating-generator-proto/mafia.pb.dart';
import 'package:seating_generator_web/utils.dart';

/// Резолвер диплинка оператора трансляции (`/broadcast`).
///
/// Публичная страница (размещена вне AppShellRoute, гард не нужен): по
/// одноразовому `key` из ссылки запрашивает RTMP-креды и открывает нативный
/// экран стрима. Не использует Bloc — простой stateful-резолвер с тремя
/// состояниями: загрузка, ошибка, переход на нативный экран.
@RoutePage()
class BroadcastPage extends StatefulWidget {
  final int tournamentId;
  final int clubId;
  final int table;
  final String broadcastKey;

  const BroadcastPage({
    super.key,
    @QueryParam('tournamentId') this.tournamentId = 0,
    @QueryParam('clubId') this.clubId = 0,
    @QueryParam('table') this.table = 0,
    @QueryParam('key') this.broadcastKey = '',
  });

  bool get isClub => clubId > 0;

  @override
  State<BroadcastPage> createState() => _BroadcastPageState();
}

enum _BroadcastErrorKind { linkExpired, tableNotConfigured, cameraPermissionDenied, generic }

class _BroadcastPageState extends State<BroadcastPage> {
  bool _loading = true;
  _BroadcastErrorKind? _errorKind;
  String? _genericErrorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _resolve());
  }

  Future<void> _resolve() async {
    final repository = RepositoryFactory.of(context).streamRepository;

    setState(() {
      _loading = true;
      _errorKind = null;
      _genericErrorMessage = null;
    });

    BroadcastCredentialsOut credentials;
    try {
      credentials = await repository.getBroadcastCredentials(
        tournamentId: widget.isClub ? null : widget.tournamentId,
        clubId: widget.isClub ? widget.clubId : null,
        table: widget.table,
        key: widget.broadcastKey,
      );
    } on BroadcastCredentialsException catch (e) {
      _showError(
        e.isLinkExpired
            ? _BroadcastErrorKind.linkExpired
            : e.isTableNotConfigured
                ? _BroadcastErrorKind.tableNotConfigured
                : _BroadcastErrorKind.generic,
        message: e.message,
      );
      return;
    } catch (e) {
      _showError(_BroadcastErrorKind.generic, message: e.toString());
      return;
    }

    if (!mounted) return;

    try {
      await MafbaseStream().openStreamScreen(
        rtmpUrl: credentials.rtmpServerUrl,
        streamKey: credentials.rtmpKey,
        // Единственный встроенный overlay; overlayDesignKey из ответа не используется.
        overlay: MafbaseOverlay.plashkiMafbase,
        tournamentId: widget.isClub ? null : widget.tournamentId,
        clubId: widget.isClub ? widget.clubId : null,
        table: widget.table,
        breakPlaceholderImageUrl:
            credentials.hasBreakPlaceholderImageUrl() ? credentials.breakPlaceholderImageUrl : null,
        brandImageUrl: credentials.hasBrandImageUrl() ? credentials.brandImageUrl : null,
      );
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSIONS_DENIED') {
        _showError(_BroadcastErrorKind.cameraPermissionDenied);
      } else {
        _showError(_BroadcastErrorKind.generic, message: e.message);
      }
      return;
    } catch (e) {
      _showError(_BroadcastErrorKind.generic, message: e.toString());
      return;
    }

    // Нативный экран закрыт пользователем (в т.ч. cold-start через диплинк):
    // уводим на /club как разумный дефолт. TODO(точка возврата обсуждаема):
    // возможно стоит возвращать в админку турнира/клуба по контексту ссылки.
    if (!mounted) return;
    context.router.replaceAll([const ClubsRoute()]);
  }

  void _showError(_BroadcastErrorKind kind, {String? message}) {
    if (!mounted) return;
    setState(() {
      _loading = false;
      _errorKind = kind;
      _genericErrorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: theme.background1,
      body: SafeArea(
        child: Center(
          child: _loading
              ? const _BroadcastLoading()
              : _BroadcastError(kind: _errorKind!, message: _genericErrorMessage, onRetry: _resolve),
        ),
      ),
    );
  }
}

class _BroadcastLoading extends StatelessWidget {
  const _BroadcastLoading();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(context.locale.broadcastLoading, style: theme.hintTextStyle, textAlign: TextAlign.center),
      ],
    );
  }
}

class _BroadcastError extends StatelessWidget {
  final _BroadcastErrorKind kind;
  final String? message;
  final VoidCallback onRetry;

  const _BroadcastError({required this.kind, required this.message, required this.onRetry});

  String _text(BuildContext context) {
    final locale = context.locale;
    switch (kind) {
      case _BroadcastErrorKind.linkExpired:
        return locale.broadcastLinkExpired;
      case _BroadcastErrorKind.tableNotConfigured:
        return locale.broadcastTableNotConfigured;
      case _BroadcastErrorKind.cameraPermissionDenied:
        return locale.broadcastCameraPermissionDenied;
      case _BroadcastErrorKind.generic:
        return locale.broadcastError(message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.videocam_off_outlined, size: 64, color: theme.greyColor),
          const SizedBox(height: 16),
          Text(
            _text(context),
            style: theme.defaultTextStyle.copyWith(color: theme.textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: context.locale.broadcastRetry,
            expand: false,
            onTap: onRetry,
          ),
          const SizedBox(height: 12),
          CustomButton(
            text: context.locale.broadcastGoHome,
            expand: false,
            minimize: true,
            onTap: () => context.router.replaceAll([const ClubsRoute()]),
          ),
        ],
      ),
    );
  }
}
