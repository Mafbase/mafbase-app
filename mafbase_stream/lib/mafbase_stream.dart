import 'package:mafbase_stream/mafbase_stream_platform_interface.dart';
import 'package:mafbase_stream/stream_event.dart';

export 'package:mafbase_stream/stream_event.dart';

/// Список встроенных overlay'ев, которые знает плагин. Хост-приложение ничего
/// не регистрирует — выбирает значение из этого enum, а плагин внутри уже
/// резолвит его в нативную Compose-вёрстку.
enum MafbaseOverlay {
  plashkiMafbase('plashki-mafbase');

  const MafbaseOverlay(this.viewType);

  /// Строковый идентификатор, который передаётся через MethodChannel на
  /// нативную сторону и резолвится в каталоге плагина.
  final String viewType;
}

class MafbaseStream {
  /// Дефолтная картинка-заглушка, которой плагин перекрывает кадр на фазе
  /// `break_phase`, если хост-приложение не передало свой URL. Хостится на
  /// `mafbase.ru` — брендированная плашка «ПЕРЕРЫВ» 1920×1080.
  static const String defaultBreakPlaceholderImageUrl = 'https://mafbase.ru/images/mafbase_break_placeholder.png';

  Future<String> getPlatformVersion() {
    return MafbaseStreamPlatform.instance.getPlatformVersion();
  }

  /// Открывает полноэкранный нативный экран превью камеры со стримом по RTMP.
  ///
  /// [rtmpUrl] — base RTMP-URL, например `rtmp://10.0.2.2/live`. [streamKey] —
  /// ключ стрима, который дополняется к URL через `/`. Если оба null — нативная
  /// сторона использует дефолты (rtmp://10.0.2.2/live, test).
  ///
  /// [overlay] — встроенный overlay, который накладывается поверх кадра
  /// в видеопотоке. Если null — стрим идёт без оверлея.
  ///
  /// [tournamentId] и [table] — параметры подписки на seatingContent для
  /// overlay'ев, которым нужны данные турнира. Передаются нативной стороне
  /// и используются overlay'ем для подключения к серверному сокету. Если
  /// overlay не требует данных — оба можно не указывать.
  ///
  /// [breakPlaceholderImageUrl] — URL картинки, которой overlay перекрывает
  /// кадр камеры на фазе `break_phase` (перерыв). На фазах `night` и
  /// `break_phase` плагин также мьютит звук с микрофона (подаёт тишину в
  /// энкодер, чтобы не ломать AV-sync). Если overlay не подписан на
  /// `broadcastPhase` — параметр не используется. Если null —
  /// используется [defaultBreakPlaceholderImageUrl].
  ///
  /// Future разрешается, когда пользователь закрывает экран.
  /// При отказе в системных разрешениях бросается [PlatformException]
  /// с кодом `PERMISSIONS_DENIED`.
  Future<void> openStreamScreen({
    String? rtmpUrl,
    String? streamKey,
    MafbaseOverlay? overlay,
    int? tournamentId,
    int? table,
    String? breakPlaceholderImageUrl,
  }) {
    return MafbaseStreamPlatform.instance.openStreamScreen(
      rtmpUrl: rtmpUrl,
      streamKey: streamKey,
      overlayViewType: overlay?.viewType,
      tournamentId: tournamentId,
      table: table,
      breakPlaceholderImageUrl: breakPlaceholderImageUrl ?? defaultBreakPlaceholderImageUrl,
    );
  }

  /// Открывает нативный экран превью оверлея — нативная view рендерится поверх
  /// однотонного фона в реальном размере кадра, без камеры и стрима.
  ///
  /// Нужен для отладки вёрстки overlay-view: можно итерировать вёрстку, не
  /// поднимая RTMP-сервер и не запуская стрим. [tournamentId] и [table] —
  /// те же, что и в [openStreamScreen]: позволяют overlay'ю поднять реальную
  /// подписку на сокет в preview-режиме.
  ///
  /// Future разрешается, когда пользователь закрывает экран.
  Future<void> openOverlayPreview({required MafbaseOverlay overlay, int? tournamentId, int? table}) {
    return MafbaseStreamPlatform.instance.openOverlayPreview(
      overlayViewType: overlay.viewType,
      tournamentId: tournamentId,
      table: table,
    );
  }

  /// Поток событий активной RTMP-сессии (адаптация битрейта, реконнекты,
  /// глубина очереди отправки). События приходят, пока native-экран стрима
  /// открыт. Подписаться можно один раз — поток broadcast.
  Stream<StreamEvent> get events => MafbaseStreamPlatform.instance.events;
}
