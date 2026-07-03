/// Событие RTMP-сессии, прилетающее из native через `EventChannel`.
///
/// Семантика отдельных полей:
///  - [bitrateBps] — текущий целевой битрейт энкодера (после возможной
///    адаптации).
///  - [queueDepthVideoMs] / [queueDepthAudioMs] — насколько глубоко легли
///    закодированные пакеты в очереди отправки. Растёт при плохой сети.
///  - [droppedFramesTotal] — кумулятивное число пакетов, отброшенных drop-
///    политикой PacketQueue за всю сессию.
///  - [reconnectAttempt] — номер текущей попытки реконнекта (0 в штатном режиме).
///  - [reason] / [ioSubcode] — заполнены при `failed` и при логировании
///    причины разрыва.
class StreamEvent {
  final StreamEventType type;
  final StreamSessionState state;
  final int bitrateBps;
  final int queueDepthVideoMs;
  final int queueDepthAudioMs;
  final int droppedFramesTotal;
  final StreamBackpressure backpressure;
  final NetworkQuality networkQuality;
  final int reconnectAttempt;
  final IoSubcode ioSubcode;
  final String? reason;

  const StreamEvent({
    required this.type,
    required this.state,
    required this.bitrateBps,
    required this.queueDepthVideoMs,
    required this.queueDepthAudioMs,
    required this.droppedFramesTotal,
    required this.backpressure,
    required this.networkQuality,
    required this.reconnectAttempt,
    required this.ioSubcode,
    required this.reason,
  });

  /// Парсит сообщение из EventChannel. Native-стороны обязаны слать Map с
  /// фиксированными ключами — несоответствие классифицируется как `state`-
  /// событие с состоянием `idle` и нулями.
  factory StreamEvent.fromMap(Map<dynamic, dynamic> map) {
    int asInt(String key) => (map[key] as num?)?.toInt() ?? 0;
    return StreamEvent(
      type: _typeFromInt(asInt('type')),
      state: _stateFromInt(asInt('state')),
      bitrateBps: asInt('bitrate_bps'),
      queueDepthVideoMs: asInt('queue_depth_video_ms'),
      queueDepthAudioMs: asInt('queue_depth_audio_ms'),
      droppedFramesTotal: asInt('dropped_frames_total'),
      backpressure: _backpressureFromInt(asInt('backpressure')),
      networkQuality: _networkQualityFromInt(asInt('network_quality')),
      reconnectAttempt: asInt('reconnect_attempt'),
      ioSubcode: _ioSubcodeFromInt(asInt('io_subcode')),
      reason: map['reason'] as String?,
    );
  }

  @override
  String toString() {
    final buf = StringBuffer('StreamEvent(${type.name}, state=${state.name}');
    if (bitrateBps > 0) buf.write(', bitrate=${bitrateBps ~/ 1000}kbps');
    if (queueDepthVideoMs > 0 || queueDepthAudioMs > 0) {
      buf.write(', queue=v${queueDepthVideoMs}ms/a${queueDepthAudioMs}ms');
    }
    if (droppedFramesTotal > 0) buf.write(', dropped=$droppedFramesTotal');
    if (backpressure != StreamBackpressure.none) buf.write(', bp=${backpressure.name}');
    if (networkQuality != NetworkQuality.good) buf.write(', net=${networkQuality.name}');
    if (reconnectAttempt > 0) buf.write(', attempt=$reconnectAttempt');
    if (ioSubcode != IoSubcode.none) buf.write(', io=${ioSubcode.name}');
    if (reason != null && reason!.isNotEmpty) buf.write(', reason="$reason"');
    buf.write(')');
    return buf.toString();
  }
}

enum StreamEventType { state, queueDepth, bitrate, reconnecting, reconnected, failed }

enum StreamSessionState { idle, connecting, streaming, reconnecting, stopped }

enum StreamBackpressure { none, low, high }

enum NetworkQuality { good, degraded, bad }

enum IoSubcode { none, timeout, eof, connreset, other }

StreamEventType _typeFromInt(int v) {
  switch (v) {
    case 0:
      return StreamEventType.state;
    case 1:
      return StreamEventType.queueDepth;
    case 2:
      return StreamEventType.bitrate;
    case 3:
      return StreamEventType.reconnecting;
    case 4:
      return StreamEventType.reconnected;
    case 5:
      return StreamEventType.failed;
    default:
      return StreamEventType.state;
  }
}

StreamSessionState _stateFromInt(int v) {
  switch (v) {
    case 0:
      return StreamSessionState.idle;
    case 1:
      return StreamSessionState.connecting;
    case 2:
      return StreamSessionState.streaming;
    case 3:
      return StreamSessionState.reconnecting;
    case 4:
      return StreamSessionState.stopped;
    default:
      return StreamSessionState.idle;
  }
}

StreamBackpressure _backpressureFromInt(int v) {
  switch (v) {
    case 0:
      return StreamBackpressure.none;
    case 1:
      return StreamBackpressure.low;
    case 2:
      return StreamBackpressure.high;
    default:
      return StreamBackpressure.none;
  }
}

NetworkQuality _networkQualityFromInt(int v) {
  switch (v) {
    case 0:
      return NetworkQuality.good;
    case 1:
      return NetworkQuality.degraded;
    case 2:
      return NetworkQuality.bad;
    default:
      return NetworkQuality.good;
  }
}

IoSubcode _ioSubcodeFromInt(int v) {
  switch (v) {
    case 0:
      return IoSubcode.none;
    case 1:
      return IoSubcode.timeout;
    case 2:
      return IoSubcode.eof;
    case 3:
      return IoSubcode.connreset;
    case 4:
      return IoSubcode.other;
    default:
      return IoSubcode.none;
  }
}
