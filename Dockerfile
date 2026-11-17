# Stage 1 - Install dependencies and build the app in a build environment
ARG REGISTRY_HOST
FROM registry.mafbase.ru/flutter-builder:3.47.9 AS build-env

RUN mkdir /app/
COPY . /app/
WORKDIR /app/

RUN flutter pub get
RUN flutter gen-l10n
RUN dart run build_runner build --delete-conflicting-outputs
RUN flutter build web --release
RUN find build/web -type f -size +1k \
    \( -name '*.js' -o -name '*.css' -o -name '*.html' -o -name '*.json' \
       -o -name '*.wasm' -o -name '*.svg' -o -name '*.otf' -o -name '*.ttf' \) \
    -exec gzip -9 -k -n {} +

# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
EXPOSE 80

# Copy the built application from the build environment
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Copy the custom NGINX configuration file
COPY nginx.conf /etc/nginx/nginx.conf
