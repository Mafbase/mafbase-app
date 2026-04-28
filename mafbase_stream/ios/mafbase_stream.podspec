#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mafbase_stream.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mafbase_stream'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{swift,h,m,mm}'
  s.public_header_files = 'Classes/Bridge/*.h'
  s.resource_bundles = {
    'mafbase_stream_overlay' => ['Assets/**/*.xcassets']
  }
  s.dependency 'Flutter'
  # SwiftProtobuf нужен для парсинга SeatingContent через wss://mafbase.ru/api/seatingContent
  # (см. TournamentContentSocket.swift). Mafia.pb.swift сгенерирован из ../seating-generator-proto
  # через `protoc --swift_out=... mafia.proto` и закоммичен в Classes/Generated/.
  s.dependency 'SwiftProtobuf', '~> 1.25'
  s.platform = :ios, '14.0'

  # C++17 для core, ARC для Obj-C++ bridge.
  s.compiler_flags = '-std=c++17'
  s.libraries = 'c++'
  s.requires_arc = true

  # CocoaPods 1.16 не добавляет -framework <name> для динамических xcframework-ов
  # автоматически (только -l для static .a). Прописываем флаги и для pod target
  # (Obj-C++ bridge ядра вызывает FFmpeg API напрямую — без них упадёт линковка
  # mafbase_stream.framework), и для user app target (transitive зависимость
  # для Runner).
  ffmpeg_ldflags = '-framework libavformat -framework libavcodec -framework libavutil -framework libswresample -framework libswscale'

  # Видим заголовки C-API ядра из Frameworks/mafbase_stream_core.xcframework
  # и системных Obj-C++ файлов.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'GCC_PREPROCESSOR_DEFINITIONS' => 'GLES_SILENCE_DEPRECATION=1',
    'HEADER_SEARCH_PATHS' => '"${PODS_TARGET_SRCROOT}/Frameworks/mafbase_stream_core.xcframework/ios-arm64/Headers" "${PODS_TARGET_SRCROOT}/Frameworks/mafbase_stream_core.xcframework/ios-arm64-simulator/Headers"',
    'OTHER_LDFLAGS' => ffmpeg_ldflags,
  }
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => ffmpeg_ldflags,
  }
  s.swift_version = '5.0'

  # Системные фреймворки — VideoToolbox/AudioToolbox для энкодеров,
  # CoreVideo/CoreMedia/AVFoundation для capture, OpenGLES для композитора.
  s.frameworks = [
    'AVFoundation',
    'AudioToolbox',
    'CoreMedia',
    'CoreVideo',
    'OpenGLES',
    'VideoToolbox',
  ]

  # Vendored: статическое C++ ядро + ffmpeg-kit prebuilt xcframework-и.
  # Сборка и распаковка делается скриптами native/scripts/build_ios.sh
  # и native/scripts/fetch_ffmpeg_ios.sh — без них pod не соберётся.
  s.vendored_frameworks = [
    'Frameworks/mafbase_stream_core.xcframework',
    'Frameworks/ffmpeg/libavformat.xcframework',
    'Frameworks/ffmpeg/libavcodec.xcframework',
    'Frameworks/ffmpeg/libavutil.xcframework',
    'Frameworks/ffmpeg/libswresample.xcframework',
    'Frameworks/ffmpeg/libswscale.xcframework',
  ]

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'mafbase_stream_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
