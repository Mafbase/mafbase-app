sealed class NotificationCoverageEvent {
  const NotificationCoverageEvent();
}

/// Новая загрузка отменяет ещё не завершённую.
final class NotificationCoverageEventLoad extends NotificationCoverageEvent {
  const NotificationCoverageEventLoad();
}
