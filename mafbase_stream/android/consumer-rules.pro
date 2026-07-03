# protobuf-javalite использует reflection по именам приватных полей `<имя>_`.
# Без этих правил R8 переименовывает поля и в runtime сыплется
#   java.lang.RuntimeException: Field roles_ for X1.d not found ...
# Правила публикуются как consumer-rules — автоматически применяются в любом
# приложении, которое подключает mafbase_stream.
-keep class * extends com.google.protobuf.GeneratedMessageLite { *; }
-keepclassmembers class * extends com.google.protobuf.GeneratedMessageLite {
    <fields>;
}
-keep class * extends com.google.protobuf.GeneratedMessageLite$Builder { *; }

# StreamSessionNative имеет static dispatch-методы, которые вызываются из C
# (JNI_OnLoad ищет их через GetStaticMethodID). R8 их обфусцирует и
# System.loadLibrary падает: "no static method dispatchEvent...".
-keep class com.example.mafbase_stream.jni.StreamSessionNative {
    public static void dispatchEvent(long, int, int, int, int, int, int, int, int, int, int, java.lang.String);
    public static void dispatchRequestKeyframe(long);
    public static void dispatchSetVideoBitrate(long, int);
}
