# Базовый образ для сборки web-приложения. Собирается вручную и пушится в registry:
#   docker build -t registry.mafbase.ru/flutter-builder:3.47.9 .
#   docker push registry.mafbase.ru/flutter-builder:3.47.9
FROM debian:bookworm-slim

ARG FLUTTER_VERSION=3.47.9

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git unzip xz-utils zip \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git /opt/flutter
ENV PATH="/opt/flutter/bin:${PATH}"

RUN flutter --disable-analytics \
    && dart --disable-analytics \
    && flutter precache --web \
    && flutter --version
