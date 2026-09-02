# Задача 04 — Хостинг apple-app-site-association (iOS universal links)

> Фича: Диплинк-трансляция оператора · Проект: seating-generator-backend · Этап: 4
> Статус: ❌ НЕ ТРЕБУЕТСЯ / отменена (2026-06-19) · Зависит от: — · Разблокирует: —
>
> **⚠️ Скорректировано по факту проверки.** Посылка BRD §1/FR-5 («iOS-диплинки не работают, нет Associated Domains / AASA») оказалась НЕВЕРНОЙ. На `mafbase.ru` уже хостятся:
> - `apple-app-site-association`: appID `L7YY6FT2M6.ru.mafbase.app`, paths `exclude /images/*` + catch-all `/*` → `/broadcast` уже покрыт;
> - `assetlinks.json`: package `ru.mafbase.app`, SHA256 fingerprint, `delegate_permission/common.handle_all_urls`.
> Также в клиенте уже есть: iOS entitlement `applinks:mafbase.ru`, `FlutterDeepLinkingEnabled`, Android intent-filter `autoVerify="true"` для `mafbase.ru`.
> Хостинг AASA к Kotlin-бэкенду отношения не имеет (отдаётся веб-хостингом). **Бэкенд-работы по этой задаче нет.**
>
> **Единственный реальный остаток (клиент, не backend):** Android intent-filter перечисляет пути явно (`/`, `/club*`, `/tournament*`, `/profile`, `/contacts`, `/translationControl`) — `/broadcast` отсутствует. Добавить в `android/app/src/main/AndroidManifest.xml`:
> `<data android:scheme="https" android:host="mafbase.ru" android:path="/broadcast" />`. iOS — ничего. Это часть клиентской задачи (FR-4), а не отдельная backend-задача.
>
> _(Исходный текст задачи ниже сохранён для истории — НЕ выполнять.)_

## Контекст
Чтобы диплинк оператора (`https://mafbase.ru/broadcast?...`) открывал приложение Mafbase, а не Safari, iOS требует, чтобы домен `mafbase.ru` отдавал файл `apple-app-site-association` (AASA) с корректным JSON и `Content-Type: application/json` без расширения `.json` в URL. Это прямая бэкенд-зависимость из BRD: FR-5 (`brd-operator-broadcast-deeplink.md:56`) и блокер из раздела «Зависимости» (`brd-operator-broadcast-deeplink.md:87`). Опционально закрываем Android App Links через `assetlinks.json` для FR-4 (`brd-operator-broadcast-deeplink.md:55`). Задача независима от Proto/БД/эндпоинтов кредов и может выполняться параллельно с 00–03.

## Зафиксированные решения
- Из контракта фичи прямых пунктов D1–D5 эта задача не затрагивает: AASA не содержит токенов, RTMP-кредов или overlay-конфигурации. Файл лишь привязывает домен к мобильному приложению. Единственное косвенное следствие D1/D2: путь `/broadcast` (по которому строятся бессрочные операторские ссылки) должен входить в `paths` AASA, чтобы любая ссылка вида `…/broadcast?...` перехватывалась приложением.

## Объём работ
### Что делаем
- Заводим новый модуль роутинга `feature/well_known/WellKnownApi.kt` с extension-функцией `fun Application.configureWellKnown()` — по образцу `fun Application.configureStreaming(...)` (`src/main/kotlin/feature/streaming/StreamingApi.kt:16`) и `fun Application.configureClubTranslation(...)` (`src/main/kotlin/feature/club_translation/ClubTranslationApi.kt:23`).
- Регистрируем два публичных (без `authenticate("auth-jwt")`) GET-роута, отдающих один и тот же AASA-JSON:
  - `GET /.well-known/apple-app-site-association`
  - `GET /apple-app-site-association`
  Оба — вне блока `authenticate(...)`, по образцу публичного `get` в `StreamingApi.kt:23-27` (там роут регистрируется до блока `authenticate`).
- Каждый роут отвечает `call.respondText(text = AASA_JSON, contentType = ContentType.Application.Json)` — критично: `Content-Type: application/json`, тело без BOM, URL без суффикса `.json`.
- Опционально (FR-4, Android App Links): `GET /.well-known/assetlinks.json` с тем же `ContentType.Application.Json`.
- Регистрируем модуль в `src/main/kotlin/Main.kt` рядом с остальными `configure*`-вызовами (после `configureStreaming(...)` на `src/main/kotlin/Main.kt:211`). Репозиторий/DI не нужен — модуль не обращается к БД, поэтому в `AppAssembly` ничего не добавляем.
- AASA- и assetlinks-JSON держим как константы прямо в `WellKnownApi.kt` (один источник правды для обоих роутов). `TeamID`, `BundleID`, Android-`SHA256` — плейсхолдеры, заменяются после получения от iOS/Android-команды (см. «Риски»).

### Что НЕ входит
- Клиентская конфигурация iOS (Associated Domains entitlement, `Info.plist`) и Android (`intent-filter`) — это работа в `mafbase-app` (FR-4, FR-5), не в бэкенде.
- Резолвер-маршрут `/broadcast` во Flutter (FR-1/FR-2) — клиент, вне scope бэкенда.
- Эндпоинт выдачи RTMP-кредов по `key` — Задача 01 (`01-broadcast-credentials-endpoint.md`).
- Никаких изменений в БД, Proto, репозиториях.

## Технические детали

### Новый файл: `src/main/kotlin/feature/well_known/WellKnownApi.kt`
Сигнатура и стиль зеркалят `configureStreaming` (`src/main/kotlin/feature/streaming/StreamingApi.kt:16-20`). Публичные роуты без `authenticate` — как публичный `get` в `StreamingApi.kt:23-27`.

```kotlin
package feature.well_known

import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import swagger.apiDoc

// ⚠️ ПЛЕЙСХОЛДЕРЫ — заменить значениями от iOS-команды (см. раздел «Риски»).
private const val APPLE_TEAM_ID = "TEAMID_PLACEHOLDER"          // например "ABCDE12345"
private const val APPLE_BUNDLE_ID = "BUNDLEID_PLACEHOLDER"      // например "ru.mafbase.app"

// Apple требует appID = "<TeamID>.<BundleID>"; путь /broadcast перехватывается приложением.
private val AASA_JSON = """
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "$APPLE_TEAM_ID.$APPLE_BUNDLE_ID",
        "paths": [ "/broadcast", "/broadcast/*" ]
      }
    ]
  }
}
""".trimIndent()

// ⚠️ ОПЦИОНАЛЬНО (FR-4). SHA256 fingerprint подписи Android-приложения — от Android-команды.
private const val ANDROID_PACKAGE_NAME = "PACKAGE_PLACEHOLDER"  // например "ru.mafbase.app"
private const val ANDROID_SHA256 = "SHA256_PLACEHOLDER"         // "AA:BB:CC:..."

private val ASSETLINKS_JSON = """
[
  {
    "relation": [ "delegate_permission/common.handle_all_urls" ],
    "target": {
      "namespace": "android_app",
      "package_name": "$ANDROID_PACKAGE_NAME",
      "sha256_cert_fingerprints": [ "$ANDROID_SHA256" ]
    }
  }
]
""".trimIndent()

fun Application.configureWellKnown() {
    routing {
        apiDoc("Apple App Site Association (universal links)")
        get("/.well-known/apple-app-site-association") {
            call.respondText(AASA_JSON, ContentType.Application.Json)
        }
        // Дублирующий путь без /.well-known — iOS проверяет оба расположения.
        get("/apple-app-site-association") {
            call.respondText(AASA_JSON, ContentType.Application.Json)
        }
        // ОПЦИОНАЛЬНО (FR-4, Android App Links).
        get("/.well-known/assetlinks.json") {
            call.respondText(ASSETLINKS_JSON, ContentType.Application.Json)
        }
    }
}
```

Замечания по реализации:
- `call.respondText(text, contentType)` — стандартный Ktor-способ отдать сырой текст с явным `Content-Type` (в проекте уже используется `call.respondFile(...)`, см. `src/main/kotlin/modules/ClubsModule.kt:123`; `respondText` — соседний API того же `io.ktor.server.response.*`).
- `ContentType.Application.Json` уже импортируется и применяется в проекте (`src/main/kotlin/Main.kt:143`, `src/main/kotlin/AppAssembly.kt:61`).
- Apple НЕ принимает AASA с расширением `.json` и НЕ исполняет редиректы — поэтому путь регистрируется буквально, без `.json` и без проксирования.
- `paths` включает и `/broadcast`, и `/broadcast/*` — query-параметры (`tournamentId|clubId&table&key`) на матчинг paths в AASA не влияют, но wildcard покрывает возможные будущие сегменты.
- Поскольку модуль не использует БД/DI, в `AppAssembly` (`src/main/kotlin/AppAssembly.kt`) ничего добавлять не нужно — в отличие от `configureStreaming`, который получает `assembly.streamingRepository`.

### Регистрация в `Main.kt`
Добавить вызов рядом с прочими модулями, после `src/main/kotlin/Main.kt:211` (`configureStreaming(...)`):

```kotlin
configureStreaming(assembly.streamingRepository, assembly.tournamentOwnersRepository)
configureWellKnown()   // ← новый
```

и импорт вверху файла (рядом с `import feature.streaming.configureStreaming` на `src/main/kotlin/Main.kt:42`):

```kotlin
import feature.well_known.configureWellKnown
```

### Структура AASA-файла (что отдаём)
- Корень: `applinks`.
- `applinks.apps`: пустой массив `[]` (требование Apple).
- `applinks.details[].appID`: строка `"<TeamID>.<BundleID>"` (например `ABCDE12345.ru.mafbase.app`).
- `applinks.details[].paths`: массив, обязательно содержащий `"/broadcast"` (а также `"/broadcast/*"`).

## Definition of Done
- [ ] Создан файл `src/main/kotlin/feature/well_known/WellKnownApi.kt` с `fun Application.configureWellKnown()`.
- [ ] `configureWellKnown()` зарегистрирован в `src/main/kotlin/Main.kt` (после `configureStreaming`, импорт добавлен).
- [ ] `GET /.well-known/apple-app-site-association` возвращает `200`, `Content-Type: application/json`, **без** авторизации (запрос без заголовка `Authorization` проходит).
- [ ] `GET /apple-app-site-association` (без `/.well-known`, без `.json`) возвращает тот же `200` + `application/json`, без авторизации.
- [ ] Тело ответа — валидный JSON, парсится; содержит `applinks.details[0].appID` в формате `TeamID.BundleID` и `applinks.details[0].paths`, включающий строку `"/broadcast"`.
- [ ] Поля `TeamID`/`BundleID` в коде явно помечены как плейсхолдеры (комментарий) с указанием, что значения предоставляет iOS-команда.
- [ ] (Опционально, FR-4) `GET /.well-known/assetlinks.json` возвращает `200` + `application/json` с валидным JSON-массивом; `package_name` и `sha256_cert_fingerprints` помечены как плейсхолдеры (значения — от Android-команды).
- [ ] `./gradlew build` — зелёный.
- [ ] (Проверочно) `curl -i https://<host>/.well-known/apple-app-site-association` показывает `Content-Type: application/json` и тело без BOM; URL не оканчивается на `.json`.

## Порядок и зависимости
- **До**: ничего из бэкенд-задач не требуется (задача независима).
- **Внешний вход (блокирующий для финальных значений, не для кода)**: реальные `TeamID` и `BundleID` от iOS-команды; для опционального assetlinks — `package_name` и `SHA256` fingerprint от Android-команды. Код пишется на плейсхолдерах; деплой реальных значений — отдельный шаг.
- **Разблокирует**: настройку Associated Domains на iOS-клиенте (FR-5) и проверку universal links на реальном устройстве; ничего из бэкенд-задач не блокирует.

## Риски / открытые вопросы
- **Внешняя зависимость (iOS)**: точные `TeamID` (Apple Developer Membership → Team ID) и `BundleID` приложения Mafbase. До их получения AASA содержит плейсхолдеры и универсальные ссылки на устройстве работать не будут.
- **Внешняя зависимость (Android, опционально)**: SHA256 fingerprint подписи релизного (и debug) сертификата — для `assetlinks.json`. Если ключей подписи несколько (debug/release/Play App Signing), в массив `sha256_cert_fingerprints` нужно добавить все.
- **Инфраструктура**: домен `https://mafbase.ru` должен отдавать эти пути напрямую с бэкенда (или через reverse-proxy без подмены `Content-Type` и без редиректов). Если перед бэкендом стоит nginx/CDN — убедиться, что `/.well-known/*` проксируется на приложение и заголовок `Content-Type` не перетирается.
- **Кэширование**: iOS кэширует AASA. При смене `appID`/`paths` потребуется переустановка приложения или ожидание сброса кэша CDN — не критично для первой выкладки.

## Затрагиваемые файлы
| Файл | Действие (создать/изменить) |
|---|---|
| `src/main/kotlin/feature/well_known/WellKnownApi.kt` | создать |
| `src/main/kotlin/Main.kt` | изменить (импорт + вызов `configureWellKnown()`) |
