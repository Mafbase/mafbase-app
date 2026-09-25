---
name: reference_mafbase_stream_ios_build
description: Как собирать iOS-часть плагина mafbase_stream (example): pod install с UTF-8 локалью после новых Swift-файлов, команды сборки, подключённый iPhone.
type: reference
---

Проверка iOS-кода плагина `mafbase_stream` идёт через example-приложение:

```
cd mafbase_stream/example && fvm flutter build ios --debug --no-codesign
```

Быстрый инкремент после первой сборки (15–60 с):

```
cd mafbase_stream/example/ios && xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Debug -sdk iphoneos -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build
```

**Why:** Список исходников плагина в Pods-проекте фиксируется в момент `pod install` — после добавления нового
файла в `ios/Classes/` сборка падает с «Cannot find X in scope», пока не выполнить
`cd mafbase_stream/example/ios && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pod install`. Без UTF-8 локали
CocoaPods 1.16 падает с `Encoding::CompatibilityError`.

**How to apply:** Новый Swift-файл → `pod install` с локалью → сборка. Симулятор без камеры бесполезен для
проверки стрима; на Mac подключён iPhone 15 Pro Max «iPhone (Сергей)», iOS 26.6, UDID
`00008130-000C642036A2001C` (`fvm flutter run -d 00008130-000C642036A2001C`), сценарии со звонком, Siri,
фоном и обрывом сети прогоняет пользователь руками. FFmpeg-xcframework'и лежат в `ios/Frameworks/`
(gitignored), тянутся `native/scripts/fetch_ffmpeg_ios.sh` из prepare_command podspec.
