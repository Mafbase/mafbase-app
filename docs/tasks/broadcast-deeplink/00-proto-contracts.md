# Задача 00 — Proto-контракты

> Фича: Диплинк-трансляция оператора · Проект: seating-generator-backend · Этап: 0
> Статус: ✅ выполнено (2026-06-19) · Зависит от: — · Разблокирует: 01, 02, 03
>
> Реализация: proto-сабмодуль `seating-generator-proto` запушен в `origin/main` (`696ff90`); backend закоммичен локально (`ea2239b`: 5 generated-файлов + указатель сабмодуля + `documentation.yaml` с полем `broadcastToken`); react подтянут на `696ff90`; web = `mafbase-app`, `make genProto` + локальный коммит `943839d`. Push backend/web — не выполнялся (ожидает общего пуша фичи).

## Контекст

Эта задача — единственный владелец всех proto-изменений итерации. Она вводит контракт обмена между бэкендом и нативным приложением оператора (FR-6: эндпоинт выдачи RTMP-кредов по `key`; FR-7: маппинг ответа в `openStreamScreen`) и контракт админ-UI для построения диплинка (FR-8) и overlay-настроек. До регенерации и распространения proto задачи 01/02/03 не могут компилироваться, поэтому 00 — жёсткий блокер.

Согласно BRD раздел 9 («Предлагаемые этапы реализации», п.1) и раздел 7 («Зависимости и риски» → Proto), proto-контракты согласуются раньше всего. BRD также предупреждает (раздел 7, Proto): уже всплыл конфликт сабмодуля `seating-generator-proto` при ребейзе — изменения нужно мержить аккуратно.

## Зафиксированные решения

- **D1** (отдельный per-table broadcast-токен). На уровне proto это значит: токен — не translation-key, а самостоятельное поле `broadcastToken`, добавляемое в `GameStreamAdmin` (поле 8), чтобы админ-UI строил диплинк оператора. В публичном `BroadcastCredentialsOut` сам токен НЕ возвращается (по нему запрашивают, его не отдают).
- **D3** (клубные стримы переиспользуют существующие сообщения). Для клубов НЕ заводим новых stream-сообщений: используем `GameStream` (mafia.proto:693-699), `GameStreamAdmin` (mafia.proto:702-710), `SetStreamEvent` (mafia.proto:713-718), `GetStreamsOut` (mafia.proto:726-728), `GetStreamsAdminOut` (mafia.proto:731-733). Сущность (турнир/клуб) задаётся роутом, а не полем в сообщении — поэтому отсутствие `tournamentId`/`clubId` в этих сообщениях здесь корректно и намеренно. Поле `broadcastToken = 8`, добавляемое в `GameStreamAdmin`, автоматически становится доступно и клубной ветке (Задача 03) — это часть мотивации переиспользования.
- **D5** (overlay-константа `plashkiMafbase` — на клиенте). Бэкенд хранит/отдаёт только `breakPlaceholderImageUrl` + `brandImageUrl` (+ опционально `overlayDesignKey`). Поэтому в `BroadcastCredentialsOut` есть эти три опциональных поля, но НЕТ самой overlay-константы; в `SetStreamSettingsEvent`/`StreamSettingsOut` — только два URL-поля.

## Объём работ

### Что делаем

- Редактируем `seating-generator-backend/seating-generator-proto/mafia.proto`, **append после строки 758** (`ClubTranslationKeyEventOut`, mafia.proto:755-758 — текущий конец файла), три новых сообщения: `BroadcastCredentialsOut`, `SetStreamSettingsEvent`, `StreamSettingsOut`.
- В существующее сообщение `GameStreamAdmin` (mafia.proto:702-710) добавляем поле `optional string broadcastToken = 8;`. Следующий свободный номер — 8 (последнее занятое `startedAt = 7` на mafia.proto:709).
- **НЕ добавляем** новых клубных stream-сообщений (D3).
- Регенерируем Kotlin/Java-код бэкенда командой из CLAUDE.md (см. «Технические детали»). Артефакты пишутся в `src/main/java/generated/Mafia.java` (существует, см. java-out) и `src/main/kotlin/generated/*Kt.kt` (существует, ~120 файлов; например `GameStreamAdminKt.kt`, `ClubTranslationKeyEventOutKt.kt`).
- Коммитим и пушим сабмодуль `seating-generator-proto` (текущая ветка `main`, отслеживает `origin/main`), затем фиксируем указатель сабмодуля в репозитории backend.
- Фиксируем необходимость подтянуть proto в web (`make genProto`) и react.
- Всё выполняется агентом `proto-sync` (`/Users/sergeianisov/development/mafbase/.claude/agents/proto-sync.md`).

### Что НЕ входит

- Изменения SQL-схемы под токен/overlay — Задачи 01 (V3), 02 (V4), 03 (V5).
- Реализация эндпоинтов и маппингов на новые сообщения — Задачи 01/02/03.
- Любые клубные stream-сообщения — их не существует и не будет (D3).
- Изменения на стороне web/react кроме генерации (`make genProto`/pull) — вне backend-scope.

## Технические детали

### 1. Новое сообщение `BroadcastCredentialsOut` (append после mafia.proto:758)

Публичный ответ эндпоинта выдачи кредов (Задача 01/03). Сам `broadcastToken` здесь НЕ отдаётся.

```proto
// Ответ на GET /api/broadcast/credentials — RTMP-креды стола для оператора
message BroadcastCredentialsOut {
  int32 tableNumber = 1;
  string rtmpServerUrl = 2;
  string rtmpKey = 3;
  optional string breakPlaceholderImageUrl = 4;
  optional string brandImageUrl = 5;
  optional string overlayDesignKey = 6;
}
```

### 2. Новые сообщения overlay-настроек (append после mafia.proto:758, Задача 02)

```proto
// Запрос на установку overlay-настроек стримов (турнир/клуб)
message SetStreamSettingsEvent {
  optional string breakPlaceholderImageUrl = 1;
  optional string brandImageUrl = 2;
}

// Ответ с текущими overlay-настройками стримов (турнир/клуб)
message StreamSettingsOut {
  optional string breakPlaceholderImageUrl = 1;
  optional string brandImageUrl = 2;
}
```

### 3. Добавление поля в `GameStreamAdmin` (mafia.proto:702-710)

Текущее сообщение:

```proto
// Инфо о стриме для администратора (включает RTMP)
message GameStreamAdmin {
  int32 id = 1;
  int32 tableNumber = 2;
  optional string viewerUrl = 3;
  optional string rtmpServerUrl = 4;  // только для трансляционного ПО
  optional string rtmpKey = 5;        // секретный ключ
  bool active = 6;
  string startedAt = 7;  // время начала трансляции (ISO 8601)
}
```

Добавить ровно одну строку перед закрывающей `}` (новый номер поля = 8):

```proto
  optional string broadcastToken = 8;  // токен диплинка оператора, для построения ссылки на клиенте
```

Стиль соответствует существующим `optional`-полям сообщения (mafia.proto:705-707). Номер 8 свободен (последний занятый — 7).

### 4. Команда регенерации (CLAUDE.md)

Команда из корневого `/Users/sergeianisov/development/mafbase/CLAUDE.md:12`:

```bash
protoc --java_out=src/main/java --kotlin_out=src/main/kotlin seating-generator-proto/mafia.proto
```

(Запускать из корня `seating-generator-backend`. Согласно `seating-generator-backend/CLAUDE.md:69`, Gradle также способен скачать protoc/protoc-gen-kotlin автоматически — допустим любой из вариантов, лишь бы артефакты в `src/main/java/generated` и `src/main/kotlin/generated` обновились.)

### 5. Коммит и пуш сабмодуля (порядок proto-sync, CLAUDE.md «Proto-подмодуль»)

```bash
# 1. редактируем mafia.proto в сабмодуле backend
#    seating-generator-backend/seating-generator-proto/mafia.proto
# 2. коммит + пуш сабмодуля (он на ветке main, отслеживает origin/main)
cd seating-generator-backend/seating-generator-proto
git add mafia.proto
git commit -m "proto: BroadcastCredentialsOut, Set/StreamSettings, GameStreamAdmin.broadcastToken"
git push origin main
# 3. регенерация Kotlin/Java в backend (см. п.4)
# 4. зафиксировать новый указатель сабмодуля в репозитории backend
# 5. подтянуть proto в web: cd seating-generator-web/seating-generator-proto && git pull && make genProto
# 6. подтянуть proto в react (если затронут): cd .../proto && git pull
```

⚠️ **Конфликт сабмодуля** (предупреждение BRD, раздел 7): репозиторий `seating-generator-proto` уже имел конфликт при ребейзе. Перед пушем — `git -C seating-generator-proto fetch && git status -sb`, убедиться что `main` не разошёлся с `origin/main`; при расхождении синхронизировать (merge/rebase) аккуратно, НЕ затирая чужие изменения, и только потом пушить. Это критично, т.к. сабмодуль шарится между backend/web/react.

## Definition of Done

- [ ] В `seating-generator-proto/mafia.proto` добавлены три новых сообщения с ровно теми именами и номерами полей, что в контракте: `BroadcastCredentialsOut` (поля 1-6: `tableNumber`, `rtmpServerUrl`, `rtmpKey`, optional `breakPlaceholderImageUrl`, optional `brandImageUrl`, optional `overlayDesignKey`); `SetStreamSettingsEvent` (1-2: optional `breakPlaceholderImageUrl`, optional `brandImageUrl`); `StreamSettingsOut` (1-2: те же два поля).
- [ ] В `GameStreamAdmin` добавлено поле `optional string broadcastToken = 8;` — номер именно 8, существующие поля 1-7 не тронуты.
- [ ] Новые сообщения добавлены строго append'ом после текущего конца файла (после `ClubTranslationKeyEventOut`, mafia.proto:758); порядок существующих сообщений не изменён.
- [ ] НЕ добавлено ни одного нового клубного stream-сообщения (D3 соблюдён): `GameStream`, `GameStreamAdmin`, `SetStreamEvent`, `GetStreamsOut`, `GetStreamsAdminOut` остаются единственными stream-сообщениями.
- [ ] Код сгенерирован: обновлены `src/main/java/generated/Mafia.java` и соответствующие `src/main/kotlin/generated/*Kt.kt` (как минимум появились `BroadcastCredentialsOutKt.kt`, `SetStreamSettingsEventKt.kt`, `StreamSettingsOutKt.kt`; в `GameStreamAdminKt.kt` — accessor для `broadcastToken`).
- [ ] `./gradlew build` проходит зелёным (backend компилируется с обновлённым generated-кодом; никаких unresolved reference на новые сообщения нет, т.к. потребители появятся в 01/02/03).
- [ ] Сабмодуль `seating-generator-proto` закоммичен и запушен в `origin/main`; перед пушем проверено отсутствие расхождения с `origin/main` (риск конфликта по BRD митигирован).
- [ ] Указатель сабмодуля зафиксирован коммитом в репозитории backend.
- [ ] Зафиксирована (в выводе агента/PR-описании) необходимость подтянуть proto в web (`make genProto`) и react (`git pull` сабмодуля).

## Порядок и зависимости

- **До:** ничего (этап 0, первая задача).
- **Разблокирует:** Задачу 01 (использует `BroadcastCredentialsOut`, `GameStreamAdmin.broadcastToken`), Задачу 02 (использует `SetStreamSettingsEvent`/`StreamSettingsOut`), Задачу 03 (переиспользует `GameStream*`/`SetStreamEvent` + `GameStreamAdmin.broadcastToken`).
- Критический путь разблокировки клиента: 00 → 01 (турнирный флоу).
- Выполняется агентом `proto-sync` согласно порядку из корневого CLAUDE.md.

## Риски / открытые вопросы

- **Конфликт сабмодуля `seating-generator-proto`** (BRD раздел 7): возможен при пуше из-за прошлого ребейза. Митигация — fetch + проверка `origin/main` + аккуратный merge до пуша. Если конфликт неразрешим автоматически — эскалировать пользователю до пуша.
- **Рассинхрон web/react:** после пуша сабмодуля клиенты должны подтянуть proto. В рамках этой задачи (backend-scope) выполнение `make genProto` в web и pull в react — внешняя зависимость; задача обязана это явно зафиксировать, но не обязана выполнить за пределами backend.
- **Номер поля 8:** при ребейзе/мерже чужих изменений убедиться, что номер 8 в `GameStreamAdmin` не был занят кем-то параллельно (proto не допускает переиспользования номеров).

## Затрагиваемые файлы

| Файл | Действие (создать/изменить) |
|---|---|
| `seating-generator-backend/seating-generator-proto/mafia.proto` | изменить (3 новых message + поле 8 в `GameStreamAdmin`) |
| `seating-generator-backend/src/main/java/generated/Mafia.java` | изменить (регенерация) |
| `seating-generator-backend/src/main/kotlin/generated/BroadcastCredentialsOutKt.kt` | создать (регенерация) |
| `seating-generator-backend/src/main/kotlin/generated/SetStreamSettingsEventKt.kt` | создать (регенерация) |
| `seating-generator-backend/src/main/kotlin/generated/StreamSettingsOutKt.kt` | создать (регенерация) |
| `seating-generator-backend/src/main/kotlin/generated/GameStreamAdminKt.kt` | изменить (регенерация, accessor `broadcastToken`) |
