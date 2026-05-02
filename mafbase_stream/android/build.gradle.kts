group = "com.example.mafbase_stream"
version = "1.0-SNAPSHOT"

buildscript {
    val kotlinVersion = "2.2.20"
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.11.1")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
        classpath("org.jetbrains.kotlin:compose-compiler-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id("com.android.library")
    id("kotlin-android")
    id("org.jetbrains.kotlin.plugin.compose") version "2.2.20"
    id("com.google.protobuf") version "0.9.4"
}

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

android {
    namespace = "com.example.mafbase_stream"

    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        compose = true
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
            // .proto-файлы лежат в соседнем модуле seating-generator-proto.
            // Регистрируем их как дополнительный proto-srcDir через ExtensionAware,
            // потому что Kotlin-DSL не предоставляет статического accessor'а
            // для extension'а `proto`, который добавляет com.google.protobuf.
            @Suppress("UNCHECKED_CAST")
            ((this as org.gradle.api.plugins.ExtensionAware).extensions
                .getByName("proto") as org.gradle.api.file.SourceDirectorySet)
                .srcDir(file("../../seating-generator-proto"))
        }
        getByName("test") {
            java.srcDirs("src/test/kotlin")
        }
    }

    defaultConfig {
        minSdk = 24

        ndk {
            // 32-битные armeabi-v7a и 64-битные arm64-v8a покрывают все реальные
            // Android-устройства; x86/x86_64 опускаем, чтобы не таскать лишний FFmpeg.
            abiFilters += listOf("arm64-v8a", "armeabi-v7a")
        }

        externalNativeBuild {
            cmake {
                cppFlags += "-std=c++17"
                arguments += "-DANDROID_STL=c++_shared"
            }
        }
    }

    externalNativeBuild {
        cmake {
            path = file("CMakeLists.txt")
            version = "3.22.1"
        }
    }

    testOptions {
        unitTests {
            isIncludeAndroidResources = true
            all {
                it.useJUnitPlatform()

                it.outputs.upToDateWhen { false }

                it.testLogging {
                    events("passed", "skipped", "failed", "standardOut", "standardError")
                    showStandardStreams = true
                }
            }
        }
    }
}

protobuf {
    protoc {
        artifact = "com.google.protobuf:protoc:3.25.5"
    }
    generateProtoTasks {
        all().configureEach {
            builtins {
                create("java") {
                    option("lite")
                }
            }
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.13.1")

    implementation("com.google.protobuf:protobuf-javalite:3.25.5")

    val composeBom = platform("androidx.compose:compose-bom:2026.04.01")
    implementation(composeBom)
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.compose.foundation:foundation")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.runtime:runtime")
    implementation("io.coil-kt.coil3:coil-compose:3.0.4")
    implementation("io.coil-kt.coil3:coil-network-okhttp:3.0.4")
    // OkHttp используется для websocket-подписки в overlay (см. TournamentContentSocket).
    // Версия фиксирует тот же major, что тащит coil-network-okhttp 3.0.4.
    implementation("com.squareup.okhttp3:okhttp:4.12.0")
    debugImplementation("androidx.compose.ui:ui-tooling")

    // FFmpeg .so и заголовки положены вручную:
    //   • заголовки  — android/src/main/cpp/third_party/ffmpeg/include/
    //   • рантайм .so — android/src/main/jniLibs/<abi>/lib*.so
    // Gradle автоматически упакует jniLibs в AAR/APK, CMakeLists.txt линкуется с .so
    // как IMPORTED-таргетами. Никаких maven-зависимостей на ffmpeg-kit не требуется.

    testImplementation("org.jetbrains.kotlin:kotlin-test")
    testImplementation("org.mockito:mockito-core:5.0.0")
}
