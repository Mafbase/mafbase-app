#Stage 1 - Install dependencies and build the app in a build environment
FROM ghcr.io/cirruslabs/flutter:3.10.5 as build-env

RUN mkdir /app/
COPY . /app/
WORKDIR /app/

RUN flutter build web --release
# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
EXPOSE 80
COPY --from=build-env /app/build/web /usr/share/nginx/html